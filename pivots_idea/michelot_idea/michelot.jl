#This script implement the pivots idea, which is usually called as Michelot

function michelot(y,a) #y is the input data
    let
        p=(sum(y)-a)/length(y)
        while true
            l=length(y)
            for i in 1:l
                x=popfirst!(y)
                if x>p
                    push!(y,x)
                end
            end
            p=(sum(y)-a)/length(y)
            if l==length(y)
                return p
                break
            end
        end
    end
end
