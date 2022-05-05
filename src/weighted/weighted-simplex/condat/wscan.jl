#wscan.jl
"""
    wscan(y, w, a)
Remove inactive terms in projection onto weigthed simplex.

# Arguments
- `y::AbstractVector`: input vector
- `w::AbstractVector`: weight for simplex
- `a::Real = 1`: scaling factor
```
"""
function wscan(y::AbstractVector, w::AbstractVector, a::Real = 1)::Real
    let
        #initialize pivot
        s1 = y' * w
        s2 = sum(w.^2)
        p = (s1 - a)/s2
        while true
            #record length
            l = length(y)
            #check all terms from current y
            for i in 1:l
                x = popfirst!(y)
                z = popfirst!(w)
                #remove inactive terms
                if x/z > p
                    push!(y, x)
                    push!(w, z)
                else
                    s1 = s1 - x * z
                    s2 = s2 - z * z
                    p = (s1 - a)/s2
                end
            end
            #check termination condition
            if l == length(y)
                return p
            end
        end
    end
end
