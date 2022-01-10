using Base.Threads
using BangBang
function condat_w(data,w,a)
    let
        l=length(data)
        y=cat(data,w,dims=2)
        v=w_scanLf(y,a)
        p=w_checkL(v,a)
        x=zeros(l)
        for i in 1:l
            if data[i]>w[i]*p
                x[i]=data[i]-w[i]*p
            end
        end
        return x
    end
end

function w_scanLf(y,a)
    let
        l=size(y)[1]
        v=[y[1,:]]
        p=(y[1,1]*y[1,2]-a)/(y[1,2]^2)
        u=[]
        s1=y[1,1]*y[1,2]
        s2=y[1,2]^2
        for i in 2:l
            if (y[i,1]/y[i,2])>p
                p=(s1+y[i,1]*y[i,2]-a)/(s2)
                if p>(y[i,1]*y[i,2]-a)/(y[i,2]^2)
                    push!(v,y[i,:])
                    s1+=y[i,1]*y[i,2]
                    s2+=y[i,2]^2
                else
                    append!!(u,v)
                    v=[y[i,:]]
                    p=(y[i,1]*y[i,2]-a)/(y[i,2]^2)
                    s1=y[i,1]*y[i,2]
                    s2=y[i,2]^2
                end
            end
        end
        while !(u==[])
            x=pop!(u)
            if (x[1]/x[2])>p
                push!(v,x)
                s1+=x[1]*x[2]
                s2+=x[2]^2
                p=(s1-a)/s2
            end
        end
        return v
    end
end

function w_checkL(v,a)
    let
        s1=0
        s2=0
        for i in 1:size(v)[1]
            s1+=v[i][1]*v[i][2]
            s2+=v[i][2]^2
        end
        p=(s1-a)/s2
        while true
            l=size(v)[1]
            for i in 1:l
                x=popfirst!(v)
                if x[1]/x[2] <= p
                    s1=s1-x[1]*x[2]
                    s2=s2-x[2]*x[2]
                    p=(s1-a)/s2
                else
                    push!(v,x)
                end
            end
            if l==length(v)
                break
            end
        end
        return p
    end
end

function pcondat_w(data,w,a)
    let
        l=length(data)
        y=cat(data,w,dims=2)
        v=w_pscanLf(y,a)
        p=w_checkL(v,a)
        x=zeros(l)
        @threads for i in 1:l
            if data[i]>w[i]*p
                x[i]=data[i]-w[i]*p
            end
        end
        return x
    end
end

function w_pscanLf(y,a)
    let
        l=size(y)[1]
        d=ceil(Int,l/nthreads())
        spl=SpinLock()
        un=[]
        @threads for i in 1:nthreads()
            let
                st=(threadid()-1)*d+1
                en=min(st+d-1,l)
                p=(y[st,1]*y[st,2]-a)/(y[st,2]^2)
                s1=y[st,1]*y[st,2]
                s2=y[st,2]^2
                u=[y[st,:]]
                w=[]
                for j in (st+1):en
                    if (y[j,1]/y[j,2])>p
                        p=(s1+y[j,1]*y[j,2]-a)/(s2+y[j,2]^2)
                        if p>(y[j,1]*y[j,2]-a)/(y[j,2]^2)
                            push!(u,y[j,:])
                            s1+=y[j,1]*y[j,2]
                            s2+=y[j,2]^2
                        else
                            append!!(w,u)
                            p=(y[j,1]*y[j,2]-a)/(y[j,2]^2)
                            s1=y[j,1]*y[j,2]
                            s2=y[j,2]^2
                            u=[y[j,:]]
                        end
                    end
                end
                for x in w
                    if (x[1]/x[2])>p
                        push!(u,x)
                        s1+=x[1]*x[2]
                        s2+=x[2]^2
                        p=(s1-a)/(s2)
                    end
                end
                lock(spl)
                append!!(un,u)
                unlock(spl)
            end
        end
        return un
    end
end
