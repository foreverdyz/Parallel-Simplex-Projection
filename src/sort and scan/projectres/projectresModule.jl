#projectresModule.jl

module projectres
export projectres_s, projectres_p
    include("project_res.jl")
    """
        projectres_s(data,p)

    After gained simplex projection pivot `p`, function will return projection result
        of original vector `data`.

    # Arguments
    - `data::AbstractVector`: the original vector you want to project
    - `p::AbstractFloat`: the simplex projection pivot you get before

    # Examples
    ```julia-repl
    julia> projectres_s([1,0],0.5)
    [0.5,0]
    ```
    """
    projectres_s(data::AbstractVector, p::AbstractFloat) = project_res(data,p)

    include("parallel_project_res.jl")
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
    projectres_p(data::AbstractVector, p::AbstractFloat) = parallel_project_res(data,p)
end  # module projectres
