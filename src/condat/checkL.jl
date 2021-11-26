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
function checkL(y::AbstractVector, a::Int = 1)::AbstractFloat
    (p = (sum(y)-a)/length(y))::AbstractFloat
    while true
        l = length(y)
        r = 0
        for i in 1:l
            x=popfirst!(y)
            if x <= p
                r += 1
                p = p + (p-x)/(l-r)
            else
                push!(y,x)
            end
        end
        if l == length(y)
            return p
        end
    end
end
