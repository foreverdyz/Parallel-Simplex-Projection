#benchmark_l1ball.jl

using BenchmarkTools, Random, Distributions
BenchmarkTools.DEFAULT_PARAMETERS.gcsample = true
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100
BenchmarkTools.DEFAULT_PARAMETERS.seconds = 25

include("simplex/sort and scan/sortscanModule.jl")
include("simplex/michelot/michelotModule.jl")
include("simplex/condat/condatModule.jl")
using .sortscan
using .michelot
using .condat

function benchball_sortscan(n::Int)
    Random.seed!(12345);
    res1=@benchmark sortscan_s($(abs.(rand(Normal(0, 1), n))), 1);
    println("sortscan_s, N(0, 1), size of $n, runtime ", mean(res1))
    Random.seed!(12345);
    res2=@benchmark sortscan_p($(abs.(rand(Normal(0, 1), n))), 1);
    println("sortscan_p, N(0, 1), size of $n, runtime ", mean(res2))
    Random.seed!(12345);
    res3=@benchmark sortPscan_p($(abs.(rand(Normal(0, 1), n))), 1);
    println("sortPscan_p, N(0, 1), size of $n, runtime ", mean(res3))
    Random.seed!(12345);
    res4=@benchmark sortscan_s($(abs.(rand(Normal(0, 0.001), n))), 1);
    println("sortscan_s, N(0, 0.001), size of $n, runtime ", mean(res4))
    Random.seed!(12345);
    res5=@benchmark sortscan_p($(abs.(rand(Normal(0, 0.001), n))), 1);
    println("sortscan_p, N(0, 0.001), size of $n, runtime ", mean(res5))
    Random.seed!(12345);
    res6=@benchmark sortPscan_p($(abs.(rand(Normal(0, 0.001), n))), 1);
    println("sortPscan_p, N(0, 0.001), size of $n, runtime ", mean(res6))
end

function benchball_michelot(n::Int)
    Random.seed!(12345);
    res1=@benchmark michelot_s($(abs.(rand(Normal(0, 1), n))), 1);
    println("michelot_s, N(0, 1), size of $n, runtime ", mean(res1))
    Random.seed!(12345);
    res2=@benchmark michelot_p($(abs.(rand(Normal(0, 1), n))), 1);
    println("michelot_p, N(0, 1), size of $n, runtime ", mean(res2))
    Random.seed!(12345);
    res3=@benchmark michelot_s($(abs.(rand(Normal(0, 0.001), n))), 1);
    println("michelot_s, N(0, 0.001), size of $n, runtime ", mean(res3))
    Random.seed!(12345);
    res4=@benchmark michelot_p($(abs.(rand(Normal(0, 0.001), n))), 1);
    println("michelot_p, N(0, 0.001), size of $n, runtime ", mean(res4))
end

function benchball_condat(n::Int)
    Random.seed!(12345);
    res1=@benchmark condat_s($(abs.(rand(Normal(0, 1), n))), 1);
    println("condat_s, N(0, 1), size of $n, runtime ", mean(res1))
    Random.seed!(12345);
    res2=@benchmark condat_p($(abs.(rand(Normal(0, 1), n))), 1);
    println("condat_p, N(0, 1), size of $n, runtime ", mean(res2))
    Random.seed!(12345);
    res3=@benchmark condat_s($(abs.(rand(Normal(0, 0.001), n))), 1);
    println("condat_s, N(0, 0.001), size of $n, runtime ", mean(res3))
    Random.seed!(12345);
    res4=@benchmark condat_p($(abs.(rand(Normal(0, 0.001), n))), 1);
    println("condat_p, N(0, 0.001), size of $n, runtime ", mean(res4))
end

benchball_sortscan(100_000)
benchball_sortscan(1_000_000)
benchball_sortscan(10_000_000)
benchball_sortscan(100_000_000)

benchball_michelot(100_000)
benchball_michelot(1_000_000)
benchball_michelot(10_000_000)
benchball_michelot(100_000_000)

benchball_condat(100_000)
benchball_condat(1_000_000)
benchball_condat(10_000_000)
benchball_condat(100_000_000)
#=
Random.seed!(12345); @benchmark michelot_p_l1($(rand(Normal(0, 0.001), 100_000)), 1)
Random.seed!(12345); @benchmark condat_s_l1($(rand(Normal(0, 1), 100_000)), 1)
Random.seed!(12345); @benchmark condat_p_l1($(rand(Normal(0, 1), 100_000)), 1)
Random.seed!(12345); @benchmark condat_p_l1($(rand(Normal(0, 1), 1000_000)), 1)
Random.seed!(12345); @benchmark condat_p_l1($(rand(Normal(0, 0.001), 1000_000)), 1)
=#
