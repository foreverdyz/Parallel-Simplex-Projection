#condatModule.jl
"""
# condat: condat idea for scaling standard simplex projection

    condat_s(data,a)
    condat_p(data,a)
"""
module condat
export condat_s, condat_p
    include("projectres/projectresModule.jl")
    include("checkL.jl")
    include("serial_condat.jl")
    """
        condat_s(data, a)
    Project original vector `data` onto a scaling standard simplex with scaling
        factor `a` with Condat method.

    # Arguments
    - `data::AbstractVector`: the original vector you want to project
    - `a::Int = 1`: the scaling factor of the scaling standard simplex you want
        to project

    # Examples
    ```julia-repl
    julia> condat_s([1,1], 1)
    [0.5,0.5]
    ```
    """
    condat_s(data::AbstractVector, a::Int = 1) = serial_condat(data, a)

    include("parallel_condat.jl")
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
    condat_p(data::AbstractVector, a::Int = 1) = parallel_condat(data, a)
end  # module condat
