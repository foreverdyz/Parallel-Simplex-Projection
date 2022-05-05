#parallel_scan.jl
using Base.Threads
using BangBang
include("local_scan.jl")
"""
    parallel_scan(y, w, a)
Parallel remove some inactive terms.

# Arguments
- `y::AbstractVector`: input vector
- `w::AbstractVector`: weight for simplex
- `a::Real = 1`: scaling factor
```
"""
function parallel_scan(y::AbstractVector, w::AbstractVector, a::Real = 1)
    #record the length
    l = length(y)
    #get the length of subvector
    d = ceil(Int64,l/nthreads())
    #initialize two final lists
    u = []
    v = []
    #lock global value in reducing
    spl = SpinLock()
    @threads for i in 1:nthreads()
        #get start and end point for subvector
        st = (threadid()-1)*d+1
        en = min(threadid()*d,l)
        #local scan
        x,z = local_scan(y[st:en], w[st:en], a)
        #reduce results with locking
        lock(spl)
        append!!(u, x)
        append!!(v, z)
        unlock(spl)
    end
    #output final results
    return u,v
end
