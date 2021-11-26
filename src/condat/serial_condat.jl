#serial_condat.jl
include("serial_filter.jl")
#include("checkL.jl")
using .projectres

"""
    serial_condat(data, a)
Project original vector `data` onto a scaling standard simplex with scaling
    factor `a` with Condat method.

# Notations
Run `include("projectres/projectresModule.jl")` if `using .projectres` wrong.
Run `include("serial_filter.jl")` if `serial_filter not defined`.
Run `include("checkL.jl")` if `checkL not defined`.

# Arguments
- `data::AbstractVector`: the original vector you want to project
- `a::Int = 1`: the scaling factor of the scaling standard simplex you want
    to project

# Examples
```julia-repl
julia> serial_condat([1,1], 1)
[0.5,0.5]
```
"""
function serial_condat(data::AbstractVector, a::Int = 1)::AbstractVector
    y = serial_filter(data, a)
    p = checkL(y, a)
    return projectres_s(data, p)
end
