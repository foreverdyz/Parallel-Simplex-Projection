#serial_sortscan.jl
include("scansorted.jl")
using .projectres

"""
    serial_sortscan(data,a)

Project `data` onto a scailing standard simplex with scaling factor `a`.

# Arguments
- `data::AbstractVector`: the original vector you want to project
- `a::Int=1`: the scaling factor for scaling standard simplex to project

# Notations
Run `include("projectres/projectresModule.jl")` if `using .projectres` wrong

# Examples
```julia-repl
julia> serial_sortscan([1,1],1)
[0.5,0.5]
```
"""

function serial_sortscan(data::AbstractVector, a::Real = 1)::AbstractVector
    #using quicksort here
    y = sort(data; alg=QuickSort, rev = true)
    #checking sorted terms to find τ (the final pivot we want in our paper)
    p = scansorted(y,a)
    #get projection result
    return projectres_s(data,p)
end
