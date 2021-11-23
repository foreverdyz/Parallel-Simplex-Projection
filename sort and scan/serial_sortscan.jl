#serial_sortscan.jl
include("scansorted.jl")
#include("projectresModule.jl")
using .projectres

"""
    serial_sortscan(data,a)

Project `data` onto a scailing standard simplex with scaling factor `a`.

# Arguments
- `data::AbstractVector`: the original vector you want to project
- `a::Int=1`: the scaling factor for scaling standard simplex to project

# Notations
Run `include("projectresModule.jl")` if `using .projectres` wrong

# Examples
```julia-repl
julia> serial_sortscan([1,1],1)
[0.5,0.5]
```
"""

function serial_sortscan(data::AbstractVector, a::Int = 1)::AbstractVector
    y = sort(data; alg=QuickSort, rev = true)
    p = scansorted(y,a)
    return projectres_s(data,p)
end
