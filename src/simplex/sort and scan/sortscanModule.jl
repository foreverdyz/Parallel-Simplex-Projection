#sortscanModule.jl
"""
# sortscan: basic sort and scan idea for scaling standard simplex projection

    sortscan_s(data,a)
    sortscan_p(data,a)
    sortPscan_p(data,a)

# Package Requirements
Please `run import Pkg; Pkg.add("ThreadsX")` to add package "ThreadsX"
"""
module sortscan
export sortscan_s, sortscan_p, sortPscan_p
    include("projectres/projectresModule.jl")
    include("serial_sortscan.jl")
    """
        sortscan_s(data,a)

    Project `data` onto a scailing standard simplex with scaling factor `a`.

    # Arguments
    - `data::AbstractVector`: the original vector you want to project
    - `a::Int=1`: the scaling factor for scaling standard simplex to project

    # Examples
    ```julia-repl
    julia> sortscan_s([1,1],1)
    [0.5,0.5]
    ```
    """
    sortscan_s(data::AbstractVector, a::Int = 1) = serial_sortscan(data, a)

    include("parallel_sortscan.jl")
    """
        sortscan_p(data,a)

    Project original vector `data` onto a scaling standard simplex with scaling
        factor `a` with parallel method.

    # Arguments
    - `data::AbstractVector`: the original vector you want to project
    - `a::Int = 1`: the scaling factor of the scaling standard simplex you want
        to project

    # Examples
    ```julia-repl
    julia> sortscant_p([1,1],1)
    [0.5,0.5]
    ```
    """
    sortscan_p(data::AbstractVector, a::Int = 1) = parallel_sortscan(data, a)

    include("parallel_sortPscan.jl")
    """
        sortPscan_p(data,a)

    Project original vector `data` onto a scaling standard simplex with scaling
        factor `a` with parallel method.

    # Notations
    The difference between sortPscan and sortscan is front one use parallel
        partial scan instead of parallel prefix sum in rear one.

    # Arguments
    - `data::AbstractVector`: the original vector you want to project
    - `a::Int = 1`: the scaling factor of the scaling standard simplex you want
        to project

    # Examples
    ```julia-repl
    julia> sortPscan_p([1,1],1)
    [0.5,0.5]
    ```
    """
    sortPscan_p(data::AbstractVector, a::Int = 1) = parallel_sortPscan(data, a)

end  # module sortscan

#using .sortscan to use a local module
