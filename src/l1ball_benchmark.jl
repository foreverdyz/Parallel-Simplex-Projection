#l1ball_benchmark

using BenchmarkTools, Random, Distributions
BenchmarkTools.DEFAULT_PARAMETERS.gcsample = true
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100
BenchmarkTools.DEFAULT_PARAMETERS.seconds = 10

include("simplex/sort and scan/sortscanModule.jl")
include("simplex/michelot/michelotModule.jl")
include("simplex/condat/condatModule.jl")
include("l1ball.jl")
using .sortscan
using .michelot
using .condat

"""
    benchball_sortscan()
    benchball_michelot()
    benchball_condat()
Use @benchmark to test seven methods in N(0,1) with sample sizes n=100_000,
1_000_000, 10_000_000
"""
function benchball_sortscan()
    let
        #sample sizes
        n=[100_000, 1_000_000, 10_000_000]
        for i in n
            #set random seed
            Random.seed!(12345);
            #test
            res1 = @benchmark serial_l1ball(sortscan_s, $(rand(Normal(0, 1),i)), 1)
            res2 = @benchmark sortscan_s($(abs.(rand(Normal(0, 1), i))), 1)
            println(mean(res1)," + ",mean(res2))
            Random.seed!(12345);
            res1 = @benchmark parallel_l1ball(sortscan_p, $(rand(Normal(0, 1),i)), 1)
            res2 = @benchmark sortscan_p($(abs.(rand(Normal(0, 1), i))), 1)
            println(mean(res1)," + ",mean(res2))
            Random.seed!(12345);
            res1 = @benchmark parallel_l1ball(sortPscan_p, $(rand(Normal(0, 1),i)), 1)
            res2 = @benchmark sortPscan_p($(abs.(rand(Normal(0, 1), i))), 1)
            println(mean(res1)," + ",mean(res2))
            Random.seed!(12345);
            res1 = @benchmark serial_l1ball(sortscan_s, $(rand(Normal(0, 0.001),i)), 1)
            res2 = @benchmark sortscan_s($(abs.(rand(Normal(0, 0.001), i))), 1)
            println(mean(res1)," + ",mean(res2))
            Random.seed!(12345);
            res1 = @benchmark parallel_l1ball(sortscan_p, $(rand(Normal(0, 0.001),i)), 1)
            res2 = @benchmark sortscan_p($(abs.(rand(Normal(0, 0.001), i))), 1)
            println(mean(res1)," + ",mean(res2))
            Random.seed!(12345);
            res1 = @benchmark parallel_l1ball(sortPscan_p, $(rand(Normal(0, 0.001),i)), 1)
            res2 = @benchmark sortPscan_p($(abs.(rand(Normal(0, 0.001), i))), 1)
            println(mean(res1)," + ",mean(res2))
        end
    end
end

function benchball_michelot()
    let
        n=[100_000, 1_000_000, 10_000_000]
        for i in n
            Random.seed!(12345);
            res1 = @benchmark serial_l1ball(michelot_s, $(rand(Normal(0, 1),i)), 1)
            res2 = @benchmark michelot_s($(abs.(rand(Normal(0, 1), i))), 1)
            println(mean(res1)," + ",mean(res2))
            Random.seed!(12345);
            res1 = @benchmark parallel_l1ball(michelot_p, $(rand(Normal(0, 1),i)), 1)
            res2 = @benchmark michelot_p($(abs.(rand(Normal(0, 1), i))), 1)
            println(mean(res1)," + ",mean(res2))
            Random.seed!(12345);
            res1 = @benchmark serial_l1ball(michelot_s, $(rand(Normal(0, 0.001),i)), 1)
            res2 = @benchmark michelot_s($(abs.(rand(Normal(0, 0.001), i))), 1)
            println(mean(res1)," + ",mean(res2))
            Random.seed!(12345);
            res1 = @benchmark parallel_l1ball(michelot_p, $(rand(Normal(0, 0.001),i)), 1)
            res2 = @benchmark michelot_p($(abs.(rand(Normal(0, 0.001), i))), 1)
            println(mean(res1)," + ",mean(res2))
        end
    end
end

function benchball_condat()
    let
        n=[100_000, 1_000_000, 10_000_000]
        for i in n
            Random.seed!(12345);
            res1 = @benchmark serial_l1ball(condat_s, $(rand(Normal(0, 1),i)), 1)
            res2 = @benchmark condat_s($(abs.(rand(Normal(0, 1), i))), 1)
            println(mean(res1)," + ",mean(res2))
            Random.seed!(12345);
            res1 = @benchmark parallel_l1ball(condat_p, $(rand(Normal(0, 1),i)), 1)
            res2 = @benchmark condat_p($(abs.(rand(Normal(0, 1), i))), 1)
            println(mean(res1)," + ",mean(res2))
            Random.seed!(12345);
            res1 = @benchmark serial_l1ball(condat_s, $(rand(Normal(0, 0.001),i)), 1)
            res2 = @benchmark condat_s($(abs.(rand(Normal(0, 0.001), i))), 1)
            println(mean(res1)," + ",mean(res2))
            Random.seed!(12345);
            res1 = @benchmark parallel_l1ball(condat_p, $(rand(Normal(0, 0.001),i)), 1)
            res2 = @benchmark condat_p($(abs.(rand(Normal(0, 0.001), i))), 1)
            println(mean(res1)," + ",mean(res2))
        end
    end
end
