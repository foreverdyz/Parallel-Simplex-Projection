#parallel_condat.jl
include("parallel_filter.jl")
#include("checkL.jl")
using .projectres

"""
    parallel_condat(data, a)
Project original vector `data` onto a scaling standard simplex with scaling
    factor `a` with Parallel Condat method.

# Notations
Run `include("projectres/projectresModule.jl")` if `using .projectres` wrong.
Run `include("checkL.jl")` if `checkL not defined`.

# Arguments
- `data::AbstractVector`: the original vector you want to project
- `a::Int = 1`: the scaling factor of the scaling standard simplex you want
    to project
```
"""
function parallel_condat(data::AbstractVector, a::Int = 1)::AbstractVector
    y = parallel_filter(data, a)
    p = checkL(y, a)
    return projectres_p(data, p)
end
