#benchmark_test.jl
using BenchmarkTools, Random, Distributions
BenchmarkTools.DEFAULT_PARAMETERS.gcsample = true
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100
BenchmarkTools.DEFAULT_PARAMETERS.seconds = 25
include("sort and scan/sortscanModule.jl")
include("michelot/michelotModule.jl")
include("condat/condatModule.jl")
using .sortscan
using .michelot
using .condat

"""
    benchsimplex_sortscan_s()
    benchsimplex_sortscan_p()
    benchsimplex_sortPscan_p()
    benchsimplex_michelot_s()
    benchsimplex_michelot_p()
    benchsimplex_condat_s()
    benchsimplex_condat_p()
use @benchmark to test 7 methods in three distributions, U[0,1], N[0,1],
N[0,0.001] with sample sizes n=100_000,500_000,1_000_000,5_000_000,
10_000_000,50_000_000,100_000_000.
"""
#Sort and Scan Serial Experiment
function benchsimplex_sortscan_s()
    #problem size n
    n=[100_000,500_000,1_000_000,5_000_000,10_000_000,50_000_000,100_000_000]
    re_u=[]
    #U[0,1]
    for i in n
        #set random seed
        Random.seed!(12345)
        res= @benchmark sortscan_s($(rand(i)), 1);
        push!(re_u, mean(res))
    end

    re_n=[]
    #N(0,1)
    for i in n
        Random.seed!(12345)
        res= @benchmark sortscan_s($(rand(Normal(0, 1), i)), 1);
        push!(re_n, mean(res))
    end

    re_sn=[]
    #N(0,0.001)
    for i in n
        Random.seed!(12345)
        res= @benchmark sortscan_s($(rand(Normal(0, 0.001), i)), 1);
        push!(re_sn, mean(res))
    end
    return re_u, re_n, re_sn
end

function benchsimplex_sortscan_p()
    n=[100_000,500_000,1_000_000,5_000_000,10_000_000,50_000_000,100_000_000]
    re_u=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark sortscan_p($(rand(i)), 1);
        push!(re_u, mean(res))
    end

    re_n=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark sortscan_p($(rand(Normal(0, 1), i)), 1);
        push!(re_n, mean(res))
    end

    re_sn=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark sortscan_p($(rand(Normal(0, 0.001), i)), 1);
        push!(re_sn, mean(res))
    end
    return re_u, re_n, re_sn
end

function benchsimplex_sortPscan_p()
    n=[100_000,500_000,1_000_000,5_000_000,10_000_000,50_000_000,100_000_000]
    re_u=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark sortPscan_p($(rand(i)), 1);
        push!(re_u, mean(res))
    end

    re_n=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark sortPscan_p($(rand(Normal(0, 1), i)), 1);
        push!(re_n, mean(res))
    end

    re_sn=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark sortPscan_p($(rand(Normal(0, 0.001), i)), 1);
        push!(re_sn, mean(res))
    end
    return re_u, re_n, re_sn
end

function benchsimplex_michelot_s()
    n=[100_000,500_000,1_000_000,5_000_000,10_000_000,50_000_000,100_000_000]
    re_u=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark michelot_s($(rand(i)), 1);
        push!(re_u, mean(res))
    end

    re_n=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark michelot_s($(rand(Normal(0, 1), i)), 1);
        push!(re_n, mean(res))
    end

    re_sn=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark michelot_s($(rand(Normal(0, 0.001), i)), 1);
        push!(re_sn, mean(res))
    end
    return re_u, re_n, re_sn
end

function benchsimplex_michelot_p()
    n=[100_000,500_000,1_000_000,5_000_000,10_000_000,50_000_000,100_000_000]
    re_u=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark michelot_p($(rand(i)), 1);
        push!(re_u, mean(res))
    end

    re_n=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark michelot_p($(rand(Normal(0, 1), i)), 1);
        push!(re_n, mean(res))
    end

    re_sn=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark michelot_p($(rand(Normal(0, 0.001), i)), 1);
        push!(re_sn, mean(res))
    end
    return re_u, re_n, re_sn
end

function benchsimplex_condat_s()
    n=[100_000,500_000,1_000_000,5_000_000,10_000_000,50_000_000,100_000_000]
    re_u=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark condat_s($(rand(i)), 1);
        push!(re_u, mean(res))
    end

    re_n=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark condat_s($(rand(Normal(0, 1), i)), 1);
        push!(re_n, mean(res))
    end

    re_sn=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark condat_s($(rand(Normal(0, 0.001), i)), 1);
        push!(re_sn, mean(res))
    end
    return re_u, re_n, re_sn
end

function benchsimplex_condat_p()
    n=[100_000,500_000,1_000_000,5_000_000,10_000_000,50_000_000,100_000_000]
    re_u=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark condat_p($(rand(i)), 1);
        push!(re_u, mean(res))
    end

    re_n=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark condat_p($(rand(Normal(0, 1), i)), 1);
        push!(re_n, mean(res))
    end

    re_sn=[]
    for i in n
        Random.seed!(12345)
        res= @benchmark condat_p($(rand(Normal(0, 0.001), i)), 1);
        push!(re_sn, mean(res))
    end
    return re_u, re_n, re_sn
end
