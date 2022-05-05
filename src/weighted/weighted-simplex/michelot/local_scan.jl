#local_scan.jl
include("weight_scan.jl")
"""
    local_scan(y,w,a)
Remove inactive terms from vector serially.

# Arguments
- `y::AbstractVector`: input vector
- `w::AbstractVector`: weight for simplex
- `a::Real = 1`: scaling factor of simplex
```
"""
function local_scan(y::AbstractVector, w::AbstractVector, a::Real = 1)
    let
        #initialize pivot
        s1 = w' * y
        s2 = sum(w.^2)
        p = (s1-a)/s2
        while true
            #record length
            l = length(y)
            #weighted scan
            y,w = w_scan(y, w, p)
            #check terminal condition
            if length(y) == l
                return y,w
            end
            #update pivot
            s1 = w' * y
            s2 = sum(w.^2)
            p = (s1-a)/s2
        end
    end
end
