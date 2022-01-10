#prefix_threads.jl

using Base.Threads
function prefix_threads!(y::AbstractVector)::AbstractVector
    l = length(y)
    k = ceil(Int,log2(l))
    for j = 1:k
        @threads for i = 2^j:2^j:min(l, 2^k)
            @inbounds y[i] = y[i - 2^(j - 1)] + y[i]
        end
    end
    for j = (k-1):-1:1
        @threads for i = 3 * 2^(j-1):2^j:min(l, 2^k)
            @inbounds y[i] = y[i - 2^(j - 1)] + y[i]
        end
    end
    return y
end
