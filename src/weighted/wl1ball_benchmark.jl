#wl1ball_benchmark.jl

using BenchmarkTools, Random, Distributions
BenchmarkTools.DEFAULT_PARAMETERS.gcsample = true
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100
BenchmarkTools.DEFAULT_PARAMETERS.seconds = 10

include("weighted simplex/wsimplexModule.jl")
include("weighted_l1ball.jl")
using. wsimplex

"""
    benchwl1ball(n)
Use @benchmark to test six methods to projection onto the weighted l1ball with
input vector is from N(0,1) and weight is from U[0,1].

# Arguments
- 'n::Int': sample size
"""
function benchwl1ball(n::Int)
    Random.seed!(12345);
    res1=@benchmark serial_wl1ball(wsortscan_s, $(rand(Normal(0, 1), n)), $(rand(n)), 1);
    println(mean(res1))
    Random.seed!(12345);
    res2=@benchmark parallel_wl1ball(wsortscan_p, $(rand(Normal(0, 1), n)), $(rand(n)), 1);
    println(mean(res2))

    Random.seed!(12345);
    res1=@benchmark serial_wl1ball(wmichelot_s, $(rand(Normal(0, 1), n)), $(rand(n)), 1);
    println(mean(res1))
    Random.seed!(12345);
    res2=@benchmark parallel_wl1ball(wmichelot_p, $(rand(Normal(0, 1), n)), $(rand(n)), 1);
    println(mean(res2))

    Random.seed!(12345);
    res1=@benchmark serial_wl1ball(wcondat_s, $(rand(Normal(0, 1), n)), $(rand(n)), 1);
    println(mean(res1))
    Random.seed!(12345);
    res2=@benchmark parallel_wl1ball(wcondat_p, $(rand(Normal(0, 1), n)), $(rand(n)), 1);
    println(mean(res2))
end

#run experiments
benchwl1ball(100_000)
benchwl1ball(500_000)
benchwl1ball(1_000_000)
benchwl1ball(5_000_000)
benchwl1ball(10_000_000)
