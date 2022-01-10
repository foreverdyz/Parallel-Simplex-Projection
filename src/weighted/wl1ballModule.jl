#wl1ballModule.jl

module wl1ball
export wsortscan_s_l1, wsortscan_p_l1, wmichelot_s_l1, wmichelot_p_l1, wcondat_s_l1, wcondat_p_l1
    include("weighted simplex/wsimplexModule.jl")

    include("weighted l1ball/sortscan_w_l1.jl")
    wsortscan_s_l1(data::AbstractVector, w::AbstractVector, a::Real = 1) = sortscan_w_l1(data, w, a)
    wsortscan_p_l1(data::AbstractVector, w::AbstractVector, a::Real = 1) = psortscan_w_l1(data, w, a)

    include("weighted l1ball/michelot_w_l1.jl")
    wmichelot_s_l1(data::AbstractVector, w::AbstractVector, a::Real = 1) = michelot_w_l1(data, w, a)
    wmichelot_p_l1(data::AbstractVector, w::AbstractVector, a::Real = 1) = pmichelot_w_l1(data, w, a)

    include("weighted l1ball/condat_w_l1.jl")
    wcondat_s_l1(data::AbstractVector, w::AbstractVector, a::Real = 1) = condat_w_l1(data, w, a)
    wcondat_p_l1(data::AbstractVector, w::AbstractVector, a::Real = 1) = pcondat_w_l1(data, w, a)
end  # module wl1ball
