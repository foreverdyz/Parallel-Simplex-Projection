#l1ball_pModule.jl
"""
# l1ball_p: l1ball includes seven methods to project a vector onto a l1 ball
    with scaling factor a.

    sortscan_p_l1(data,a)
    sortPscan_p_l1(data,a)
    michelot_p_l1(data,a)
    condat_p_l1(data,a)
"""
module l1ball_p
export sortscan_p_l1, sortPscan_p_l1, michelot_p_l1, condat_p_l1
using ThreadsX
include("simplex/sort and scan/sortscanModule.jl")
using .sortscan
function sortscan_p_l1(data::AbstractVector, a::Int = 1):: AbstractVector
    return sortscan_p(data, a)
end

function sortPscan_p_l1(data::AbstractVector, a::Int = 1):: AbstractVector
    return sortPscan_p(data, a)
end

include("simplex/michelot/michelotModule.jl")
using .michelot
function michelot_p_l1(data::AbstractVector, a::Int = 1):: AbstractVector
    return michelot_p(data, a)
end

include("simplex/condat/condatModule.jl")
using .condat
function condat_p_l1(data::AbstractVector, a::Int = 1):: AbstractVector
    return condat_p(data, a)
end

end  # module l1ball_p
