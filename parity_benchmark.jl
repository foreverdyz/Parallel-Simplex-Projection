#parity_benchmark.jl

using BenchmarkTools, Random, Distributions
BenchmarkTools.DEFAULT_PARAMETERS.gcsample = true
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100
BenchmarkTools.DEFAULT_PARAMETERS.seconds = 10
include("simplex/sort and scan/sortscanModule.jl")
include("simplex/michelot/michelotModule.jl")
include("simplex/condat/condatModule.jl")
include("parity.jl")

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

"""
    benchball_sortscan()
    benchball_michelot()
    benchball_condat()
Use @benchmark to test seven methods in U[1,2] with sample size n-1

# Notations
res1 is the runtime for projection onto the paritypolytope, and res2 is the runtime for
projection onto the simplex
"""
function bench_pp(n::Int)
    Random.seed!(12345);
    res = @benchmark serial_parity(sortscan_s, $(rand(n-1).+1));
    res1 = @benchmark sortscan_s($(pre_pp(rand(n-1).+1)));
    println(mean(res), " + ", mean(res1))
    Random.seed!(12345);
    res = @benchmark parallel_parity(sortscan_p, $(rand(n-1).+1));
    res1 = @benchmark sortscan_p($(pre_pp(rand(n-1).+1)));
    println(mean(res), " + ", mean(res1))
    Random.seed!(12345);
    res = @benchmark parallel_parity(sortPscan_p, $(rand(n-1).+1));
    res1 = @benchmark sortPscan_p($(pre_pp(rand(n-1).+1)));
    println(mean(res), " + ", mean(res1))
    Random.seed!(12345);
    res = @benchmark serial_parity(michelot_s, $(rand(n-1).+1));
    res1 = @benchmark michelot_s($(pre_pp(rand(n-1).+1)));
    println(mean(res), " + ", mean(res1))
    Random.seed!(12345);
    res = @benchmark parallel_parity(michelot_p, $(rand(n-1).+1));
    res1 = @benchmark michelot_p($(pre_pp(rand(n-1).+1)));
    println(mean(res), " + ", mean(res1))
    Random.seed!(12345);
    res = @benchmark serial_parity(condat_s, $(rand(n-1).+1));
    res1 = @benchmark condat_s($(pre_pp(rand(n-1).+1)));
    println(mean(res), " + ", mean(res1))
    Random.seed!(12345);
    res = @benchmark parallel_parity(condat_p, $(rand(n-1).+1));
    res1 = @benchmark condat_p($(pre_pp(rand(n-1).+1)));
    println(mean(res), " + ", mean(res1))
end
