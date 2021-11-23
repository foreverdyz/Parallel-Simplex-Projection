#parallel_sortPscan
#import Pkg; Pkg.add("ThreadsX")
using ThreadsX
include("parallel_partialscan.jl")
#include("projectresModule.jl")
using .projectres

"""
    parallel_sortPscan(data,a)

Project original vector `data` onto a scaling standard simplex with scaling
    factor `a` with parallel method.

# Arguments
- `data::AbstractVector`: the original vector you want to project
- `a::Int = 1`: the scaling factor of the scaling standard simplex you want
    to project

# Notations
Run `include("projectresModule.jl")` if `using .projectres` wrong

# Examples
```julia-repl
julia> parallel_sortsPcant([1,1],1)
[0.5,0.5]
```
"""

function parallel_sortPscan(data::AbstractVector,a::Int = 1)::AbstractVector
    #alg=ThreadsX.MergeSort will sort `data` parallel
    y = sort(data; alg = ThreadsX.MergeSort, rev = true)
    t = parallel_partialscan(y,a)
    #calculate p
    (p = (sum(y[1:t])-a)/t)
    return projectres_p(data,p)
end
