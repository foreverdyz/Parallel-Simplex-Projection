#wsimplexModule.jl
"""
# wsimplex: methods to projection onto a weighted simplex
    wsortscan_s(data, w, a)
    wsortscan_p(data, w, a)
    wmichelot_s(data, w, a)
    wmichelot_p(data, w, a)
    wcondat_s(data, w, a)
    wcondat_p(data, w, a)
"""
module wsimplex
export wsortscan_s, wsortscan_p, wmichelot_s, wmichelot_p, wcondat_s, wcondat_p
    include("sortscan/sortscan_serial.jl")
    include("sortscan/sortscan_parallel.jl")
    wsortscan_s(data::AbstractVector, w::AbstractVector, a::Real = 1) = serial_wsortscan(data, w, a)
    wsortscan_p(data::AbstractVector, w::AbstractVector, a::Real = 1) = parallel_wsortscan(data, w, a)

    include("michelot/michelot_serial.jl")
    include("michelot/michelot_parallel.jl")
    wmichelot_s(data::AbstractVector, w::AbstractVector, a::Real = 1) = serial_wmichelot(data, w, a)
    wmichelot_p(data::AbstractVector, w::AbstractVector, a::Real = 1) = parallel_wmichelot(data, w, a)

    include("condat/condat_serial.jl")
    include("condat/condat_parallel.jl")
    wcondat_s(data::AbstractVector, w::AbstractVector, a::Real = 1) = serial_wcondat(data, w, a)
    wcondat_p(data::AbstractVector, w::AbstractVector, a::Real = 1) = parallel_wcondat(data, w, a)
end  # module wsimplex
