#parallel_scan.jl
using Base.Threads
using BangBang
include("local_scan.jl")

"""
    parallel_scan(y,a)

parallel scan `y` to remove little terms in local.

# Arguments
- `y::AbstractVector`: the vector you want to scan
- `a::Int = 1`: the scaling factor for the scaling standard simplex
"""
function parallel_scan(y::AbstractVector, a::Int = 1)::AbstractVector
    l=length(y)
    d=ceil(Int64,l/nthreads())
    u=[]
    spl=SpinLock()
    @threads for i in 1:nthreads()
        st=(threadid()-1)*d+1
        en=min(threadid()*d,l)
        v=local_scan(y[st:en],a)
        lock(spl)
        append!!(u, v)
        unlock(spl)
    end
    return u
end
