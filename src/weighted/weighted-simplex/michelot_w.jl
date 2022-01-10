using Base.Threads
function michelot_w(data,w,a)
    let
        l=length(data)
        y=cat(data,w,dims=2)
        p=w_michelot_scan(y,a)
        x=zeros(l)
        for i in 1:l
            if data[i]>w[i]*p
                x[i]=data[i]-w[i]*p
            end
        end
        return x
    end
end

function w_michelot_scan(y,a)
    let
        l=size(y)[1]
        s1=y[:,1]'*y[:,2]
        s2=y[:,2]'*y[:,2]
        p=(s1-a)/s2
        v=[]
        for i in 1:l
            if (y[i,1]/y[i,2])>p
                push!(v,y[i,:])
            else
                s1=s1-y[i,1]*y[i,2]
                s2=s2-y[i,2]^2
            end
        end
        p=(s1-a)/s2
        while true
            l=length(v)
            for i in 1:l
                x=popfirst!(v)
                if (x[1]/x[2])>p
                    push!(v,x)
                else
                    s1=s1-x[1]*x[2]
                    s2=s2-x[2]^2
                end
            end
            p=(s1-a)/s2
            if l==length(v)
                return p
            end
        end
    end
end

function pmichelot_w(data,w,a)
    let
        l=length(data)
        y=cat(data,w,dims=2)
        v=w_michelot_pscan(y,a)
        p=w_michelot_scan2(v,a)
        x=zeros(l)
        @threads for i in 1:l
            if data[i]>w[i]*p
                x[i]=data[i]-w[i]*p
            end
        end
        return x
    end
end

function w_michelot_pscan(y,a)
    let
        l=size(y)[1]
        d=ceil(Int,l/nthreads())
        spl=SpinLock()
        un=[]
        @threads for i in 1:nthreads()
            let
                st=(threadid()-1)*d+1
                en=min(st+d-1,l)
                u=w_michelot_scan_d(y[st:en,:],a)
                lock(spl)
                append!!(un,u)
                unlock(spl)
            end
        end
        return un
    end
end

function w_michelot_scan_d(y,a)
    let
        l=size(y)[1]
        s1=y[:,1]'*y[:,2]
        s2=y[:,2]'*y[:,2]
        p=(s1-a)/s2
        v=[]
        for i in 1:l
            if (y[i,1]/y[i,2])>p
                push!(v,y[i,:])
            else
                s1=s1-y[i,1]*y[i,2]
                s2=s2-y[i,2]^2
            end
        end
        p=(s1-a)/s2
        while true
            l=length(v)
            for i in 1:l
                x=popfirst!(v)
                if (x[1]/x[2])>p
                    push!(v,x)
                else
                    s1=s1-x[1]*x[2]
                    s2=s2-x[2]^2
                end
            end
            p=(s1-a)/s2
            if l==length(v)
                return v
            end
        end
    end
end

function w_michelot_scan2(y,a)
    let
        l=size(y)[1]
        s1=0
        s2=0
        for i in 1:l
            s1+=y[i][1]*y[i][2]
            s2+=y[i][2]^2
        end
        p=(s1-a)/s2
        while true
            l=length(y)
            for i in 1:l
                x=popfirst!(y)
                if (x[1]/x[2])>p
                    push!(y,x)
                else
                    s1=s1-x[1]*x[2]
                    s2=s2-x[2]^2
                end
            end
            p=(s1-a)/s2
            if l==length(y)
                return p
            end
        end
    end
end
