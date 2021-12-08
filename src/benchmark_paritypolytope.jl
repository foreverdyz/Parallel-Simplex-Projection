#benchmark_paritypolytope.jl

using BenchmarkTools, Random, Distributions
BenchmarkTools.DEFAULT_PARAMETERS.gcsample = true
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100
BenchmarkTools.DEFAULT_PARAMETERS.seconds = 10
#=
include("simplex/sort and scan/sortscanModule.jl")
include("simplex/michelot/michelotModule.jl")
include("simplex/condat/condatModule.jl")
=#
using .sortscan
using .michelot
using .condat

"""
    pre_pp
Pre-processing original vector `data` for experiments. After pre-processing,
vector can be directly projected onto simplex, and result is the projection from
`data` onto the paritypolytope.

# Arguments
- `data::AbstractVector`: the orignal vector you want to project.

"""
function pre_pp(data::AbstractVector)::AbstractVector
    let
        f=Array{AbstractFloat}(undef, length(data))
        for i in 1:length(data); f[i] = data[i] < 0 ? 0 : 1; end
        if sum(f)%2 == 0
            i = findmin(abs.(data))[2]
            f[i] = 1 - f[i]
        end
        v=Array{AbstractFloat}(undef, length(data))
        for i in 1:length(data)
            v[i] = data[i]*(-1)^(f[i])
        end
        return v
    end
end

function bench_pp(n::Int)
    Random.seed!(12345);
    res1=@benchmark sortscan_s($(pre_pp(rand(n-1).+1)));
    println("sortscan_s, U[1,2], size of $n, runtime ", mean(res1))
    Random.seed!(12345);
    res2=@benchmark sortscan_p($(pre_pp(rand(n-1).+1)));
    println("sortscan_p, U[1,2], size of $n, runtime ", mean(res2))
    Random.seed!(12345);
    res3=@benchmark sortPscan_p($(pre_pp(rand(n-1).+1)));
    println("sortPscan_p, U[1,2], size of $n, runtime ", mean(res3))
    Random.seed!(12345);
    res4=@benchmark michelot_s($(pre_pp(rand(n-1).+1)));
    println("michelot_s, U[1,2], size of $n, runtime ", mean(res4))
    Random.seed!(12345);
    res5=@benchmark michelot_p($(pre_pp(rand(n-1).+1)));
    println("michelot_p, U[1,2], size of $n, runtime ", mean(res5))
    Random.seed!(12345);
    res6=@benchmark condat_s($(pre_pp(rand(n-1).+1)));
    println("condat_s, U[1,2], size of $n, runtime ", mean(res6))
    Random.seed!(12345);
    res7=@benchmark condat_p($(pre_pp(rand(n-1).+1)));
    println("condat_p, U[1,2], size of $n, runtime ", mean(res7))
end
