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
function parallel_filter(y::AbstractVector, a::Real = 1):: AbstractVector
    #record length
    l = length(y)
    #the length for subvectors
    d = floor(Int,l/nthreads())
    #lock global value
    spl = SpinLock()
    #initialize the final list
    un = []
    @threads for i in 1:nthreads()
        #do serial filter for subvectors here
        let
            #determine start and end position for subvectors
            st = (threadid()-1)*d+1
            if threadid() == nthreads()
                en = l
            else
                en = threadid()*d
            end
            #initialize pivot
            p = y[st]-a
            #initialize length
            sl = 0
            #initialize active list and waiting list
            u = [y[st]]
            w = []
            #check all terms in subvector
            for j in (st+1):en
                #remove inactive terms
                if y[j] > p
                    #update pivot
                    p += (y[j]-p)/(sl+=1)
                    if p > y[j] - a
                        push!(u, y[j])
                    else
                        #for too large pivot
                        append!!(w, u)
                        p = y[j] - a
                        sl = 1
                        u = [y[j]]
                    end
                end
            end
            #reuse terms from waiting list
            for x in w
                if x > p
                    push!(u, x)
                    p += (x-p)/(sl+=1)
                end
            end
            #add a local scan and check for remaining terms
            v=[]
            #record current length
            r = length(u)
            #update pivot for numeric accuracy
            p = (sum(u)-a)/r
            #check all terms in current u
            for x in u
                if x > p
                    push!(v, x)
                else
                    #update length pivot
                    r = r-1
                    p = p + (p-x)/(r)
                end
            end
            #reduce with locking
            lock(spl)
            append!!(un,v)
            unlock(spl)
        end
    end
    #output final active list
    return un
end
