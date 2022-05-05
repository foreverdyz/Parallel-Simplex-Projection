#michelot_serial.jl
include("weight_scan.jl")
"""
    serial_wmichelot(data, w, a)
Project a vector `data` onto a simplex with weight `w` and scaling factor `a`.

# Arguments
- `data::AbstractVector`: input vector
- `w::AbstractVector`: weight for simplex
- `a::Real = 1`: scaling factor
```
"""
function serial_wmichelot(data::AbstractVector, w::AbstractVector, a::Real = 1)::AbstractVector
    let
        s1 = w' * data
        s2 = sum(w.^2)
        #initialize the pivot
        p = (s1-a)/s2
        #avoid change raw data
        y = copy(data)
        u = copy(w)
        while true
            #record lenght
            l = length(y)
            #weighted scan
            y,u = w_scan(y, u, p)
            #update pivot
            s1 = u' * y
            s2 = sum(u.^2)
            p = (s1-a)/s2
            #check termination condition
            if length(y) == l
                break
            end
        end
        #initialize final list
        v = zeros(length(data))
        for i in 1:length(data)
            v[i] = max(0, data[i] - w[i] * p)
        end
        #output final result
        return v
    end
end
