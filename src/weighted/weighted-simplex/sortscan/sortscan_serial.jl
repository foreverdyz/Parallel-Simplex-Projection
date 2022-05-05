#sortscan_serial.jl
"""
    serial_wsortscan(data, w, a)
Project a vector `data` onto a simplex with weight `w` and scaling factor `a`.

# Arguments
- `data::AbstractVector`: input vector
- `w::AbstractVector`: weight for simplex
- `a::Real = 1`: scaling factor
```
"""
function serial_wsortscan(data::AbstractVector, w::AbstractVector, a::Real = 1)::AbstractVector
    let
        #define a new array to store data/w, data, w
        y = []
        for i in 1:length(data)
            push!(y, [data[i]/w[i], data[i], w[i]])
        end
        #sort y based on data/w
        y = sort(y; alg = QuickSort, rev = true)
        #initialize values
        s1 = 0
        s2 = 0
        p = 0
        #check all terms
        for i in 1:length(data)
            s1 += y[i][2]*y[i][3]
            s2 += y[i][3]^2
            if (s1 - a)/s2 >= y[i][2]/y[i][3]
                p = (s1 - y[i][2] * y[i][3] - a)/(s2 - y[i][3]^2)
                break
            end
        end
        #initialize final list
        x=zeros(length(data))
        for i in 1:length(data)
            if data[i] > w[i] * p
                x[i] = data[i] - w[i]*p
            end
        end
        #output final result
        return x
    end
end
