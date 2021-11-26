#parallel_filter.jl
using Base.Threads
using BangBang
"""
    parallel_filter(y,a)
Parallel Filter technique in Parallel Condat method.

# Arguments
- `y::AbstractVector`: the vector you want to project
- `a::Int = 1`: the scaling factor for the scaling standard simplex
```
"""
function parallel_filter(y::AbstractVector, a::Int = 1):: AbstractVector
    l = length(y)
    d = ceil(Int,l/nthreads())
    spl = SpinLock()
    un = []
    @threads for i in 1:nthreads()
        let
            st = (threadid()-1)*d+1
            en = min(st+d-1,l)
            p = y[st]-a
            sl = 0
            u = [y[st]]
            w = []
            for j in (st+1):en
                if y[j] > p
                    p += (y[j]-p)/(sl+=1)
                    if p > y[j] - a
                        push!(u, y[j])
                    else
                        append!!(w, u)
                        p = y[j] - a
                        sl = 1
                        u = [y[j]]
                    end
                end
            end
            for x in w
                if x > p
                    push!(u, x)
                    p += (x-p)/(sl+=1)
                end
            end
            v=[]
            r = length(u)
            p = (sum(u)-a)/r
            for x in u
                if x > p
                    push!(v, x)
                else
                    r = r-1
                    p = p + (p-x)/(r)
                end
            end
            lock(spl)
            append!!(un,v)
            unlock(spl)
        end
    end
    #return length(un)
    return un
end
