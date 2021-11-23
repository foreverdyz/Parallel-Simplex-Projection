#michelotModule.jl
"""
# michelot: michelot idea for scaling standard simplex projection

    michelot_s(data,a)
    michelot_p(data,a)
"""
module michelot
export michelot_s, michelot_p
    include("projectres/projectresModule.jl")
    include("serial_michelot.jl")
    """
        michelot_s(data, a)
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
    julia> michelot_s([1,1], 1)
    [0.5,0.5]
    ```
    """
    michelot_s(data::AbstractVector, a::Int = 1) = serial_michelot(data, a)

    include("parallel_michelot.jl")
    """
        michelot_p(data, a)
    Project original vector `data` onto a scaling standard simplex with scaling
        factor `a` with parallel Michelot method.

    # Notations
    Run `include("projectres/projectresModule.jl")` if `using .projectres` wrong.

    # Arguments
    - `data::AbstractVector`: the original vector you want to project
    - `a::Int = 1`: the scaling factor of the scaling standard simplex you want
        to project

    # Examples
    ```julia-repl
    julia> michelot_p([1,1], 1)
    [0.5,0.5]
    ```
    """
    michelot_p(data::AbstractVector, a::Int = 1) = parallel_michelot(data, a)

end  # module michelot
