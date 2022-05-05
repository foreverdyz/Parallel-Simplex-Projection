#parallel_filter.jl
using Base.Threads
using BangBang

"""
    parallel_filter(data, w, a)
Parallel filter `data` for projection onto a weighted simplex.

# Arguments
- `data::AbstractVector`: input vector
- `w::AbstractVector`: weight for simplex
- `a::Real = 1`: scaling factor of simplex
```
"""
function parallel_filter(data::AbstractVector, w::AbstractVector, a::Real = 1)
    let
        #record length
        l = length(data)
        #get length for subvector
        d = floor(Int64,l/nthreads())
        #initialize two final lists
        mu = []
        v = []
        #lock global values in reducing
        spl = SpinLock()
        @threads for i in 1:nthreads()
            #get start and end points for subvector
            st = (threadid()-1)*d+1
            if threadid() == nthreads()
                en = l
            else
                en = threadid()*d
            end
            #initialize
            y = [data[st]]
            u = [w[st]]
            s1 = data[st] * w[st]
            s2 = w[st]^2
            p = (s1 - a)/(s2)
            w1 = []
            w2 = []
            #check all terms in subvector
            for i in st:en
                #remove inactive terms
                if data[i]/w[i] > p
                    p = (s1 + data[i] * w[i] - a)/(s2 + w[i]^2)
                    if p > (data[i] * w[i] - a)/(w[i]^2)
                        push!(y, data[i])
                        push!(u, w[i])
                        s1 += data[i] * w[i]
                        s2 += w[i]^2
                    else
                        #for large pivot
                        append!!(w1, y)
                        append!!(w2, u)
                        y = [data[i]]
                        u = [w[i]]
                        s1 = data[i] * w[i]
                        s2 = w[i]^2
                        p = (s1 - a)/s2
                    end
                end
            end
            #reuse terms from waiting list
            while !(w1 == [])
                x = pop!(w1)
                z = pop!(w2)
                if (x/z) > p
                    push!(y, x)
                    push!(u, z)
                    s1 += x * z
                    s2 += z^2
                    p = (s1 - a)/s2
                end
            end
            #finish projection onto weighted simplex projection for subvector
            while true
                #record length
                len = length(y)
                #check all terms from current y
                for i in 1:len
                    x = popfirst!(y)
                    z = popfirst!(u)
                    #remove inactive terms
                    if x/z > p
                        push!(y, x)
                        push!(u, z)
                    else
                        s1 = s1 - x * z
                        s2 = s2 - z * z
                        p = (s1 - a)/s2
                    end
                end
                #check termination condition
                if len == length(y)
                    break
                end
            end
            #reduce with locking
            lock(spl)
            append!!(mu, y)
            unlock(spl)
            lock(spl)
            append!!(v, u)
            unlock(spl)
        end
        #output final results
        return mu,v
    end
end
