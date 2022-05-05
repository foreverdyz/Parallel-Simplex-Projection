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
function serial_filter(y::AbstractVector, a::Real = 1):: AbstractVector
    #initialize active list
    v = [y[1]]
    #initialize pivot
    p = v[1]-a
    #initialize waiting list
    u = []
    for i in 2:length(y)
        #remove inactive terms
        if y[i] > p
            #update pivot
            p = p + (y[i]-p)/(length(v)+1)
            if p > y[i]-a
                push!(v, y[i])
            else
                #if pivot is too large, push previous list to waiting list
                append!!(u, v)
                v = [y[i]]
                p = y[i]-a
            end
        end
    end
    #reuse some terms from waiting list
    for x in u
        if x > p
            push!(v,x)
            p = p + (x-p)/length(v)
        end
    end
    #output active list
    return v
end
