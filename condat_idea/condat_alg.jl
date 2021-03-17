#This script implement the Condat's algorithm without multiple threads

function condat(data,a) #data is the input and a is the constant number
    #v=copy(data)
    v=scanLf(data,a)
    global p=(sum(v)-a)/length(v)
    while true
        global p
        l=length(v)
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
        if l==length(v)
            break
        end
    end
    return p
end

function scanLf(y,a)
    l=length(y)
    global p=y[1]-a
    v=[y[1]]
    u=[]
    for i in 2:l
        global p
        if y[i]>p
            p=p+(y[i]-p)/(length(v)+1)
            if p>y[i]-a
                push!(v,y[i])
            else
                u=cat(u,v,dims=1)
                v=[y[i]]
                p=y[i]-a
            end
        end
    end
    while !(u==[])
        global p
        x=pop!(u)
        if x>p
            push!(v,x)
            p=p+(x-p)/length(v)
        end
    end
    return v
end
