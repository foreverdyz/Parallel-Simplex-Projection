#scansorted.jl
"""
    scansorted(y,a)

Scan a sorted vector `y` to find projection pivot for scaling standard simplex
    with scaling factor `a`.

# Arguments
- `y::AbstractVector`: the sorted vector you want to scan
- `a::Int=1`: the scaling factor for scaling standard simplex to project

# Examples
```julia-repl
julia> scansorted([1,1],1)
0.5
```
"""
function scansorted(y::AbstractVector, a::Real = 1)::AbstractFloat
    #initialize the partial summation
    s = -a
    #initialize the length
    l = 0
    for x in y
        if (s+x)/(l+1) > x
            break
        end
        #update summation and length
        s += x
        l += 1
    end
    #output the pivot
    return s/l
end
