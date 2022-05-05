#checkL.jl

"""
    checkL(y,a)
Scan vector `y` and discard less terms until all remaining entires are active
    in projection onto scaling standard simplex with scaling factor `a`. Then,
    return the current pivot.

# Arguments
- `y::AbstractVector`: the vector you want to scan
- `a::Int = 1`: the scaling factor for the scaling standard simplex

# Examples
```julia-repl
julia> checkL([1,1], 1)
0.5
```
"""
function checkL(y::AbstractVector, a::Real = 1)::AbstractFloat
    #initialize pivot, this step is used to improve numeric accuracy
    p = (sum(y)-a)/length(y)
    while true
        #record length
        l = length(y)
        #r is number of terms will be removed in this round
        r = 0
        #check all terms in current y
        for i in 1:l
            x=popfirst!(y)
            if x <= p
                r += 1
                #update pivot
                p = p + (p-x)/(l-r)
            else
                push!(y,x)
            end
        end
        #check termination condition
        if l == length(y)
            return p
        end
    end
end
