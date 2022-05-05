#condat_serial.jl
include("wFilter.jl")
include("wscan.jl")

"""
    serial_wcondat(data, w, a)
Project `data` onto a weighted simplex.

# Arguments
- `data::AbstractVector`: input vector
- `w::AbstractVector`: weight for simplex
- `a::Real = 1`: scaling factor of simplex
```
"""
function serial_wcondat(data::AbstractVector, w::AbstractVector, a::Real = 1)::AbstractVector
    let
        #filter
        y,u = wfilter(data, w, a)
        #scan and check remaining terms
        p = wscan(y, u, a)
        #intialize final list
        v = zeros(length(data))
        for i in 1:length(data)
            if data[i]> w[i] * p
                v[i] = data[i] - w[i] * p
            end
        end
        #output projection result
        return v
    end
end
