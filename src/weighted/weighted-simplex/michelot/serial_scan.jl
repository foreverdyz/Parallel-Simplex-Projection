#serial_scan.jl
"""
    serial_scan(data, w, a)
Remove some inactive terms.

# Arguments
- `data::AbstractVector`: input vector
- `w::AbstractVector`: weight for simplex
- `a::Real = 1`: scaling factor
```
"""
function serial_scan(data::AbstractVector, w::AbstractVector, a::Real = 1)::Real
    let
        #initialize pivot
        s1 = w' * data
        s2 = sum(w.^2)
        p = (s1-a)/s2
        #avoid change raw data
        y = copy(data)
        u = copy(w)
        while true
            #record length
            l = length(y)
            #weighted scan
            y,u = w_scan(y, u, p)
            #udpate pivot
            s1 = u' * y
            s2 = sum(u.^2)
            p = (s1-a)/s2
            #check termination condition
            if length(y) == l
                return p
            end
        end
    end
end
