#condat_parallel.jl
include("parallel_filter.jl")
include("wscan.jl")
using Base.Threads

"""
    parallel_wcondat(data, w, a)
Parallel project `data` onto a weighted simplex.

# Arguments
- `data::AbstractVector`: input vector
- `w::AbstractVector`: weight for simplex
- `a::Real = 1`: scaling factor of simplex
```
"""
function parallel_wcondat(data::AbstractVector, w::AbstractVector, a::Real = 1)::AbstractVector
    let
        #parallel filter
        y,u = parallel_filter(data, w, a)
        #scan and check remaining terms
        p = wscan(y, u, a)
        #initialize final list
        v = zeros(length(data))
        @threads for i in 1:length(data)
            if data[i]> w[i] * p
                @inbounds v[i] = data[i] - w[i] * p
            end
        end
        #output projection result
        return v
    end
end
