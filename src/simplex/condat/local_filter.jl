#local_filter.jl
#include("serial_filter.jl")

"""
    local_filter(y,a)
It includes filter and one loop of checking.

# Arguments
- `y::AbstractVector`: the vector you want to project
- `a::Int = 1`: the scaling factor for the scaling standard simplex

# Notations
Run `include("serial_filter.jl")` if exists `serial_filter not defined`.


# Examples
```julia-repl
julia> local_filter([3,2,1], 1)
[3]
```
"""
function local_filter(y::AbstractVector, a::Int = 1):: AbstractVector
    y = serial_filter(y,a)
    (l = length(y))::Int
    (p = (sum(y)-a)/l)::AbstractFloat
    for i in 1:l
        x = popfirst!(y)
        if x > p
            push!(y, x)
        else
            l += -1
            p = p + (p-x)/l
        end
    end
    return y
end
