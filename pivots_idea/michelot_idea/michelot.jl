#This script implement the pivots idea, which is usually called as Michelot

function michelot(y,a) #y is the input data
    let
        p=(sum(y)-a)/length(y)
        while true
            l=length(y)
            v=[]
            for i in 1:l
                if y[i]>p
                    push!(v,y[i])
                end
            end
            p=(sum(v)-a)/length(v)
            if l==length(v)
                global τ=p
                break
            end
            y=copy(v)
        end
    end
    return τ
end
