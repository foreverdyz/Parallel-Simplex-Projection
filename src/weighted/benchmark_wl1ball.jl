#benchmark_wl1ball.jl

using BenchmarkTools, Random, Distributions
BenchmarkTools.DEFAULT_PARAMETERS.gcsample = true
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100
BenchmarkTools.DEFAULT_PARAMETERS.seconds = 10

include("wl1ballModule.jl")

using. wl1ball

function benchwl1ball(n::Int)
    Random.seed!(12345);
    res1=@benchmark wsortscan_s_l1($(rand(Normal(0, 1), n)), $(rand(n)), 1);
    println("wsortscan_s, size of $n, runtime ", mean(res1))
    Random.seed!(12345);
    res2=@benchmark wsortscan_p_l1($(rand(Normal(0, 1), n)), $(rand(n)), 1);
    println("wsortscan_p, size of $n, runtime ", mean(res2))

    Random.seed!(12345);
    res1=@benchmark wmichelot_s_l1($(rand(Normal(0, 1), n)), $(rand(n)), 1);
    println("wmichelot_s, size of $n, runtime ", mean(res1))
    Random.seed!(12345);
    res2=@benchmark wmichelot_p_l1($(rand(Normal(0, 1), n)), $(rand(n)), 1);
    println("wmichelot_p, size of $n, runtime ", mean(res2))

    Random.seed!(12345);
    res1=@benchmark wcondat_s_l1($(rand(Normal(0, 1), n)), $(rand(n)), 1);
    println("wcondat_s, size of $n, runtime ", mean(res1))
    Random.seed!(12345);
    res2=@benchmark wcondat_p_l1($(rand(Normal(0, 1), n)), $(rand(n)), 1);
    println("wcondat_p, size of $n, runtime ", mean(res2))
end
