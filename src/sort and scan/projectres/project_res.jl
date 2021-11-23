#project_res.jl
"""
    project_res(data,p)

After gained simplex projection pivot `p`, function will return projection result
    of original vector `data`.

# Arguments
- `data::AbstractVector`: the original vector you want to project
- `p::AbstractFloat`: the simplex projection pivot you get before

# Examples
```julia-repl
julia> project_res([1,0],0.5)
[0.5,0]
```
"""
function project_res(data::AbstractVector,p::AbstractFloat)::AbstractVector
    res=zeros(length(data))
    for i in 1:length(data)
        if data[i] > p
            res[i] = data[i]-p
        end
    end
    return res
end
