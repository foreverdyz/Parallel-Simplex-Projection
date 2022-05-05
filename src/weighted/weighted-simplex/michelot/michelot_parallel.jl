#michelot_parallel.jl
include("parallel_scan.jl")
include("serial_scan.jl")
using Base.Threads

"""
    parallel_wmichelot(data, w, a)
Project a vector `data` onto a simplex with weight `w` and scaling factor `a`.

# Arguments
- `data::AbstractVector`: input vector
- `w::AbstractVector`: weight for simplex
- `a::Real = 1`: scaling factor
```
"""
function parallel_wmichelot(data::AbstractVector, w::AbstractVector, a::Real = 1)::AbstractVector
    let
        #parallel scan
        y,u = parallel_scan(data, w, a)
        #final serial projection
        p = serial_scan(y, u, a)
        #intialize final list
        v = zeros(length(data))
        @threads for i in 1:length(data)
            @inbounds v[i] = max(0, data[i] - w[i] * p)
        end
        #output final result
        return v
    end
end
