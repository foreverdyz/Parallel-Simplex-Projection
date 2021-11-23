#parallel_partialscan.jl
using Base.Threads
"""
    parallel_partialscan(y,a)

For sorted vector `y`, parallel scan it and find position which can help us
    find pivot for simplex projection. The least length of y should be 16.

# Arguments
- `y::AbstractVector`: the original vector you want to project
- `a::Int = 1`: the scaling factor for the scaling standard simplex

"""
function parallel_partialscan(y::AbstractVector, a::Int = 1)::Int
    l=length(y)
    if l<=16
        println("Error: the length of y should be at least 16!")
        return 0
    end
    k=ceil(Int,log2(l))
    s=copy(y)
    p=14
    #broadcast stage
    for j=1:k
        @threads for i =2^j:2^j:min(l,2^k)
            @inbounds s[i]=s[i-2^(j-1)]+s[i]
        end
        pivot=(s[min(l,2^j)]-a)/min(l,2^j)
        if pivot>=y[min(l,2^j)]
            p=j
            break
        end
    end
    #reduce stage
    st=2^(p-1)
    for j = (p-1):-1:1
        i=min(st+2^(j-1),l)
        s[i]=s[st]+s[i]
        pivot=(s[i]-a)/i
        if pivot<y[i]
            st=i
        elseif pivot==y[i] || i==l
            break
        end
    end
    return st
end
