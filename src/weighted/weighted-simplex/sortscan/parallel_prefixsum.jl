#parallel_prefxisum.jl
using Base.Threads
"""
    parallel_prefixsum!(y)

Calculate prefix sum of vector `y` parallel.

# Arguments
- `y::AbstractVector`: the vector you want to get prefix sum

# Examples
```julia-repl
julia> parallel_prefixsum!([1,1])
[1,2]
```
"""
function parallel_prefixsum!(y::AbstractVector)
    l = length(y)
    k = ceil(Int,log2(l))
    for j = 1:k
        @threads for i = 2^j:2^j:min(l,2^k)
            @inbounds y[i] = y[i-2^(j-1)] + y[i]
        end
    end
    for j = (k-1):-1:1
        @threads for i = 3*2^(j-1):2^j:min(l,2^k)
            @inbounds y[i] = y[i-2^(j-1)] + y[i]
        end
    end
    return y
end
