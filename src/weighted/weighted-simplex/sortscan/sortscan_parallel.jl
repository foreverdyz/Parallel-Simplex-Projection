#sortscan_parallel.jl
using ThreadsX
using Base.Threads

include("parallel_prefixsum.jl")
"""
    parallel_wsortscan(data, w, a)
Project a vector `data` onto a simplex with weight `w` and scaling factor `a`.

# Arguments
- `data::AbstractVector`: input vector
- `w::AbstractVector`: weight for simplex
- `a::Real = 1`: scaling factor
```
"""
function parallel_wsortscan(data::AbstractVector, w::AbstractVector, a::Real = 1)::AbstractVector
    let
        #define a new array to store data/w, data, w
        y = []
        for i in 1:length(data)
            push!(y, [data[i]/w[i], data[i], w[i]])
        end
        #sort y based on data/w
        y = sort(y; alg = ThreadsX.MergeSort, rev = true)
        #initialize values
        x1 = zeros(length(data))
        x2 = zeros(length(data))
        @threads for i in 1:length(data)
            @inbounds x1[i] = y[i][2] * y[i][3]
            @inbounds x2[i] = y[i][3]^2
        end
        #get prifix sum
        parallel_prefixsum!(x1)
        parallel_prefixsum!(x2)
        #initialize pivot
        p = 0
        for i in 1:length(data)
            if ((x1[i] - a)/x2[i]) >= y[i][1]
                p = (x1[i-1] - a)/x2[i-1]
                break
            end
        end
        #initialize final list
        x = zeros(length(data))
        @threads for i in 1:length(data)
            if data[i] > w[i] * p
                @inbounds x[i] = data[i] - w[i]*p
            end
        end
        #output final result
        return x
    end
end
