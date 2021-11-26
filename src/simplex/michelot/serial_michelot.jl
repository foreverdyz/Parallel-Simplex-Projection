#serial_michelot.jl
include("serial_scan.jl")
using .projectres

"""
    serial_michelot(data, a)
Project original vector `data` onto a scaling standard simplex with scaling
    factor `a` with Michelot method.

# Notations
Run `include("projectres/projectresModule.jl")` if `using .projectres` wrong.

# Arguments
- `data::AbstractVector`: the original vector you want to project
- `a::Int = 1`: the scaling factor of the scaling standard simplex you want
    to project

# Examples
```julia-repl
julia> serial_michelot([1,1], 1)
[0.5,0.5]
```
"""

function serial_michelot(data::AbstractVector, a::Int = 1):: AbstractVector
    #data[1:end] will avoid `serial_scan` change original data
    p=serial_scan(data[1:end], a)
    return projectres_s(data, p)
end
