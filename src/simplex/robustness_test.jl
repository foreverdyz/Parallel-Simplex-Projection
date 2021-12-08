#robustness_test.jl
using BenchmarkTools, Random, Distributions
BenchmarkTools.DEFAULT_PARAMETERS.gcsample = true
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100
BenchmarkTools.DEFAULT_PARAMETERS.seconds = 10
#include("sort and scan/sortscanModule.jl")
#include("michelot/michelotModule.jl")
#include("condat/condatModule.jl")
using .sortscan
using .michelot
using .condat

n=1_000_000

#unit vector d=(1,0,...,0)
Random.seed!(12345);
res1=@benchmark sortscan_s($(shuffle(push!(zeros(n-1),1))),1);
Random.seed!(12345);
res2=@benchmark sortscan_p($(shuffle(push!(zeros(n-1),1))),1);
Random.seed!(12345);
res3=@benchmark sortPscan_p($(shuffle(push!(zeros(n-1),1))),1);
Random.seed!(12345);
res4=@benchmark michelot_s($(shuffle(push!(zeros(n-1),1))),1);
Random.seed!(12345);
res5=@benchmark michelot_p($(shuffle(push!(zeros(n-1),1))),1);
Random.seed!(12345);
res6=@benchmark condat_s($(shuffle(push!(zeros(n-1),1))),1);
Random.seed!(12345);
res7=@benchmark condat_p($(shuffle(push!(zeros(n-1),1))),1);
println(mean(res1))
println(mean(res2))
println(mean(res3))
println(mean(res4))
println(mean(res5))
println(mean(res6))
println(mean(res7))
#Big a (a=8)
Random.seed!(12345);
res1=@benchmark sortscan_s($(rand(Normal(0,1),n)),8);
Random.seed!(12345);
res2=@benchmark sortscan_p($(rand(Normal(0,1),n)),8);
Random.seed!(12345);
res3=@benchmark sortPscan_p($(rand(Normal(0,1),n)),8);
Random.seed!(12345);
res4=@benchmark michelot_s($(rand(Normal(0,1),n)),8);
Random.seed!(12345);
res5=@benchmark michelot_p($(rand(Normal(0,1),n)),8);
Random.seed!(12345);
res6=@benchmark condat_s($(rand(Normal(0,1),n)),8);
Random.seed!(12345);
res7=@benchmark condat_p($(rand(Normal(0,1),n)),8);
println(mean(res1))
println(mean(res2))
println(mean(res3))
println(mean(res4))
println(mean(res5))
println(mean(res6))
println(mean(res7))
#Mixing Data
Random.seed!(12345);
res1=@benchmark sortscan_s($(shuffle(push!(rand(Normal(0,0.001),n-1),1))),1);
Random.seed!(12345);
res2=@benchmark sortscan_p($(shuffle(push!(rand(Normal(0,0.001),n-1),1))),1);
Random.seed!(12345);
res3=@benchmark sortPscan_p($(shuffle(push!(rand(Normal(0,0.001),n-1),1))),1);
Random.seed!(12345);
res4=@benchmark michelot_s($(shuffle(push!(rand(Normal(0,0.001),n-1),1))),1);
Random.seed!(12345);
res5=@benchmark michelot_p($(shuffle(push!(rand(Normal(0,0.001),n-1),1))),1);
Random.seed!(12345);
res6=@benchmark condat_s($(shuffle(push!(rand(Normal(0,0.001),n-1),1))),1);
Random.seed!(12345);
res7=@benchmark condat_p($(shuffle(push!(rand(Normal(0,0.001),n-1),1))),1);
println(mean(res1))
println(mean(res2))
println(mean(res3))
println(mean(res4))
println(mean(res5))
println(mean(res6))
println(mean(res7))
