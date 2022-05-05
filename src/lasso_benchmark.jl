#lasso_benchmark.jl
using Random, Distributions
using BenchmarkTools, Random, Distributions
BenchmarkTools.DEFAULT_PARAMETERS.gcsample = true
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100
BenchmarkTools.DEFAULT_PARAMETERS.seconds = 25
include("simplex/sort and scan/sortscanModule.jl")
include("simplex/michelot/michelotModule.jl")
include("simplex/condat/condatModule.jl")
include("lasso.jl")
using .sortscan
using .michelot
using .condat

"""
    benchlasso_sortscan()
    benchlasso_michelot()
    benchlasso_condat()
Use @benchmark to test seven methods with `A` from N(0,1) and `b` from U[0,1] with sample sizes n=100_000,
1_000_000, 10_000_000
"""
function benchlasso_sortscan()
    let
        #size of A, b
        n = [100_000, 1_000_000, 10_000_000]
        m = 10
        #set random seed
        Random.seed!(12345);
        res1 = @benchmark lasso_serial($(rand(Normal(0,1),m,n)), $(rand(m)), $(rand(n)), 1, sortscan_s);
        Random.seed!(12345);
        res2 = @benchmark lasso_parallel($(rand(Normal(0,1),m,n)), $(rand(m)), $(rand(n)), 1, sortscan_p);
        Random.seed!(12345);
        res3 = @benchmark lasso_parallel($(rand(Normal(0,1),m,n)), $(rand(m)), $(rand(n)), 1, sortPscan_p);
        println(mean(res1))
        println(mean(res2))
        println(mean(res3))
    end
end

function benchlasso_michelot()
    let
        #size of A, b
        n = [100_000, 1_000_000, 10_000_000]
        m = 10
        #set random seed
        Random.seed!(12345);
        res1 = @benchmark lasso_serial($(rand(Normal(0,1),m,n)), $(rand(m)), $(rand(n)), 1, michelot_s);
        Random.seed!(12345);
        res2 = @benchmark lasso_parallel($(rand(Normal(0,1),m,n)), $(rand(m)), $(rand(n)), 1, michelot_p);
        println(mean(res1))
        println(mean(res2))
    end
end

function benchlasso_condat()
    let
        #size of A, b
        n = [100_000, 1_000_000, 10_000_000]
        m = 10
        #set random seed
        Random.seed!(12345);
        res1 = @benchmark lasso_serial($(rand(Normal(0,1),m,n)), $(rand(m)), $(rand(n)), 1, condat_s);
        Random.seed!(12345);
        res2 = @benchmark lasso_parallel($(rand(Normal(0,1),m,n)), $(rand(m)), $(rand(n)), 1, condat_p);
        println(mean(res1))
        println(mean(res2))
    end
end
