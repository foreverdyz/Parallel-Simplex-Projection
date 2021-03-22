using Base.Threads

function pscanLf(y,a)
    l=length(y)
    num=nthreads()
    v=[]
    u=[]
    p=[]
    for i in 1:num
        push!(v,[y[i]])
        push!(u,[])
        push!(p,y[i]-a)
    end

    @threads for i in (num+1):l
        j=threadid()
        if y[i]>p[j]
            p[j]=p[j]+(y[i]-p[j])/(length(v[j])+1)
            if p[j]>y[i]-a
                push!(v[j],y[i])
            else
                u[j]=cat(u[j],v[j],dims=1)
                v[j]=[y[i]]
                p[j]=y[i]-a
            end
        end
    end

    vn=[]
    un=[]
    for i in 1:num
        vn=cat(vn,v[i],dims=1)
        un=cat(un,u[i],dims=1)
    end
    let
        p=(sum(vn)-a)/length(vn)
        while !(un==[])
            x=pop!(un)
            if x>p
                push!(v,x)
                p=p+(x-p)/length(v)
            end
        end
    end
    return vn
end


function pcondat(data,a)
    #if length(data)<=10_000
    #    p=condat(data,a)
    #    return p
    #end
    v=pscanLf(data,a)
    global p=(sum(v)-a)/length(v)
    while true
        l=length(v)
        global p
        if l <= 3_000
            let
                r=0
                for i in 1:l
                    x=popfirst!(v)
                    if x <= p
                        r+=1
                        p=p+(p-x)/(l-r)
                    else
                        push!(v,x)
                    end
                end
            end
        else
            num=nthreads()
            s=zeros(num)
            u=[]
            pi=[]
            for i in 1:num
                push!(u,[])
                push!(pi,p)
            end
            @threads for i in 1:l
                j=threadid()
                if v[i]>pi[j]
                    pi[j]=pi[j]+(v[i]-pi[j])/(length(u[j])+1)
                    push!(u[j],v[i])
                end
            end
            v=[]
            for i in 1:num
                v=cat(v,u[i],dims=1)
            end
            p=(sum(v)-a)/length(v)
        end
        if l==length(v)
            break
        end
    end
    return p
end

