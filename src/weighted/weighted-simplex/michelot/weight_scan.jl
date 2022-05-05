#weight_scan.jl
"""
    w_scan(y, w, a)
Remove inactive terms in projection onto weigthed simplex.

# Arguments
- `y::AbstractVector`: input vector
- `w::AbstractVector`: weight for simplex
- `a::Real = 1`: scaling factor
```
"""
function w_scan(y::AbstractVector, w::AbstractVector, p::Real)
    let
        #record length
        l = length(y)
        #check all terms in current y
        for i in 1:l
            x = popfirst!(y)
            z = popfirst!(w)
            #remove inactive terms
            if x/z > p
                push!(y,x)
                push!(w,z)
            end
        end
        #output final results
        return y,w
    end
end
