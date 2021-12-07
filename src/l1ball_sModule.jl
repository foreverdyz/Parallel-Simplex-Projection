#l1ball_sModule.jl
"""
# l1ball_s: l1ball includes seven methods to project a vector onto a l1 ball
    with scaling factor a.

    sortscan_s_l1(data,a)
    michelot_s_l1(data,a)
    condat_s_l1(data,a)
"""
module l1ball_s
export sortscan_s_l1, michelot_s_l1, condat_s_l1
include("simplex/sort and scan/sortscanModule.jl")
using .sortscan
function sortscan_s_l1(data::AbstractVector, a::Int = 1):: AbstractVector
    if sum(data) <= a
        return data
    end
    return sortscan_s(data, a)
end

include("simplex/michelot/michelotModule.jl")
using .michelot
function michelot_s_l1(data::AbstractVector, a::Int = 1):: AbstractVector
    if sum(data) <= a
        return data
    end
    return michelot_s(data, a)
end

include("simplex/condat/condatModule.jl")
using .condat
function condat_s_l1(data::AbstractVector, a::Int = 1):: AbstractVector
    if ThreadsX(data) <= a
        return data
    end
    return condat_s(data, a)
end

end  # module l1ball_s
