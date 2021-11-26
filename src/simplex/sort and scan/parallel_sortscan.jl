#parallel_sortscan.jl
#import Pkg; Pkg.add("ThreadsX")
using ThreadsX
include("parallel_prefixsum.jl")
using .projectres
"""
    parallel_sortscan(data,a)

Project original vector `data` onto a scaling standard simplex with scaling
    factor `a` with parallel method.

# Arguments
- `data::AbstractVector`: the original vector you want to project
- `a::Int = 1`: the scaling factor of the scaling standard simplex you want
    to project

# Notations
Run `include("projectres/projectresModule.jl")` if `using .projectres` wrong

# Examples
```julia-repl
julia> parallel_sortscant([1,1],1)
[0.5,0.5]
```
"""
function parallel_sortscan(data::AbstractVector,a::Int = 1)::AbstractVector
    #alg=ThreadsX.MergeSort will sort `data` parallel
    y=sort(data; alg = ThreadsX.MergeSort, rev = true)
    prefixS=copy(y)
    parallel_prefixsum!(prefixS)
    #calculate pivot
    (p = (prefixS[end]-a)/length(y))::AbstractFloat
    for i in 1:length(y)
        if (prefixS[i]-a)/i > y[i]
            p = (prefixS[i-1]-a)/(i-1)
            break
        end
    end
    return projectres_p(data,p)
end
