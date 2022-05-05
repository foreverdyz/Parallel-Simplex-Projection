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
    #record length
    l = length(y)
    #how many layers in prefix sum
    k = ceil(Int,log2(l))
    #reduce stage
    for j = 1:k
        @threads for i = 2^j:2^j:min(l,2^k)
            @inbounds y[i] = y[i-2^(j-1)] + y[i]
        end
    end
    #broadcase stage
    for j = (k-1):-1:1
        @threads for i = 3*2^(j-1):2^j:min(l,2^k)
            @inbounds y[i] = y[i-2^(j-1)] + y[i]
        end
    end
    #return prefix sum
    return y
end
