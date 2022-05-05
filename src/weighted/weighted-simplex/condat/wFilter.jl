#wFilter.jl
using BangBang

"""
    wfilter(data, w, a)
Filter `data` for projection onto a weighted simplex.

# Arguments
- `y::AbstractVector`: input vector
- `w::AbstractVector`: weight for simplex
- `a::Real = 1`: scaling factor of simplex
```
"""
function wfilter(data::AbstractVector, w::AbstractVector, a::Real = 1)
    let
        #initialize
        y = [data[1]]
        u = [w[1]]
        s1 = data[1] * w[1]
        s2 = w[1]^2
        p = (s1 - a)/(s2)
        w1 = []
        w2 = []
        #check all terms
        for i in 2:length(data)
            #remove inactive terms
            if data[i]/w[i] > p
                #update pivot
                p = (s1 + data[i] * w[i] - a)/(s2 + w[i]^2)
                if p > (data[i] * w[i] - a)/(w[i]^2)
                    push!(y, data[i])
                    push!(u, w[i])
                    s1 += data[i] * w[i]
                    s2 += w[i]^2
                else
                    #for large pivot
                    append!!(w1, y)
                    append!!(w2, u)
                    y = [data[i]]
                    u = [w[i]]
                    s1 = data[i] * w[i]
                    s2 = w[i]^2
                    p = (s1 - a)/s2
                end
            end
        end
        #reuse terms from waiting list
        while !(w1 == [])
            x = pop!(w1)
            z = pop!(w2)
            if (x/z) > p
                push!(y, x)
                push!(u, z)
                s1 += x * z
                s2 += z^2
                p = (s1 - a)/s2
            end
        end
        #output final results
        return y, u
    end
end
