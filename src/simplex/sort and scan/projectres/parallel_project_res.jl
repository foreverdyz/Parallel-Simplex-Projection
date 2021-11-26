#parallel_project_res.jl
using Base.Threads
"""
    parallel_project_res(data,p)

After gained simplex projection pivot `p`, function will return projection result
    of original vector `data` with parallel method.

# Arguments
- `data::AbstractVector`: the original vector you want to project
- `p::AbstractFloat`: the simplex projection pivot you get before

# Examples
```julia-repl
julia> parallel_project_res([1,0],0.5)
[0.5,0]
```
"""
function parallel_project_res(data::AbstractVector, p::AbstractFloat)::AbstractVector
    res=zeros(length(data))
    @threads for i in 1:length(data)
        if data[i] > p
            @inbounds res[i] = data[i]-p
        end
    end
    return res
end
