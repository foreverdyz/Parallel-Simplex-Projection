#serial_filter.jl
using BangBang
"""
    serial_filter(y,a)
Filter technique in Condat method.

# Arguments
- `y::AbstractVector`: the vector you want to project
- `a::Int = 1`: the scaling factor for the scaling standard simplex

# Examples
```julia-repl
julia> serial_filter([3,2,1], 1)
[3]
```
"""
function serial_filter(y::AbstractVector, a::Int = 1):: AbstractVector
    v = [y[1]]
    (p = v[1]-a)::AbstractFloat
    u = []
    for i in 2:length(y)
        if y[i] > p
            p = p + (y[i]-p)/(length(v)+1)
            if p > y[i]-a
                push!(v, y[i])
            else
                append!!(u, v)
                v = [y[i]]
                p = y[i]-a
            end
        end
    end
    for x in u
        if x > p
            push!(v,x)
            p = p + (x-p)/length(v)
        end
    end
    u = nothing
    return v
end
