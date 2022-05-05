#parallel_michelot.jl
include("parallel_scan.jl")
#include("serial_scan.jl")
using .projectres

"""
    parallel_michelot(data, a)
Project original vector `data` onto a scaling standard simplex with scaling
    factor `a` with parallel Michelot method.

# Notations
Run `include("projectres/projectresModule.jl")` if `using .projectres` wrong.
Run `include("serial_scan.jl")` if `serial_scan not defined`

# Arguments
- `data::AbstractVector`: the original vector you want to project
- `a::Int = 1`: the scaling factor of the scaling standard simplex you want
    to project

# Examples
```julia-repl
julia> parallel_michelot([1,1], 1)
[0.5,0.5]
```
"""
function parallel_michelot(data::AbstractVector,a::Real = 1)::AbstractVector
    #parallel projection for subvectors
    y=parallel_scan(data, a)
    #final projection in serial
    p=serial_scan(y, a)
    #output projection result
    return projectres_p(data,p)
end
