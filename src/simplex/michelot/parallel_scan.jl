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
function parallel_scan(y::AbstractVector, a::Real = 1)::AbstractVector
    #record length
    l = length(y)
    #calculate length of subvectors
    d = floor(Int64,l/nthreads())
    #initialize final list
    u=[]
    #lock u in reducing
    spl = SpinLock()
    @threads for i in 1:nthreads()
        #calculate the start position and end position of subvectors
        st=(threadid()-1)*d+1
        if threadid()==nthreads()
            en=l
        else
            en=threadid()*d
        end
        #locol projection
        v=local_scan(y[st:en],a)
        #reduce with locking u
        lock(spl)
        append!!(u, v)
        unlock(spl)
    end
    #output active list
    return u
end
