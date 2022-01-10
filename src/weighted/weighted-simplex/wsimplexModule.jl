#wsimplexModule.jl

module wsimplex
export wsortscan_s, wsortscan_p, wmichelot_s, wmichelot_p, wcondat_s, wcondat_p
    include("sortscan_w.jl")
    wsortscan_s(data::AbstractVector, w::AbstractVector, a::Real = 1) = sortscan_w(data, w, a)
    wsortscan_p(data::AbstractVector, w::AbstractVector, a::Real = 1) = psortscan_w(data, w, a)

    include("michelot_w.jl")
    wmichelot_s(data::AbstractVector, w::AbstractVector, a::Real = 1) = michelot_w(data, w, a)
    wmichelot_p(data::AbstractVector, w::AbstractVector, a::Real = 1) = pmichelot_w(data, w, a)

    include("condat_w.jl")
    wcondat_s(data::AbstractVector, w::AbstractVector, a::Real = 1) = condat_w(data, w, a)
    wcondat_p(data::AbstractVector, w::AbstractVector, a::Real = 1) = pcondat_w(data, w, a)
end  # module wsimplex
