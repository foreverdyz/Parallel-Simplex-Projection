#lasso_realdata.jl
using BenchmarkTools, Random, Distributions, DelimitedFiles
BenchmarkTools.DEFAULT_PARAMETERS.gcsample = true
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100
BenchmarkTools.DEFAULT_PARAMETERS.seconds = 15
#include("simplex/sort and scan/sortscanModule.jl")
#include("simplex/michelot/michelotModule.jl")
#include("simplex/condat/condatModule.jl")
include("lasso.jl")
include("l1ball.jl")
using .sortscan
using .michelot
using .condat
#data = open(readdlm,"real_data.txt");
#data = data[:, 3:12]
#data = data'

#news data
#data = readdlm("news.csv", ',')

#avazu-app data
#data = readdlm("avazu.csv", ',')

#kdda data
#data =  readdlm("kdda.csv", ',')

m,i = size(data)
b = data[1: 10, 1]
data = data[:, 2:i]
i = i - 1
data = data[1:10, :]
m = 10

for j in 1:m
    data[j,:] = data[j,:]/findmax(data[j,:])[1]
end

function prep_data(A::AbstractArray, b::AbstractVector, x::AbstractVector)
    g = A'*(A*x+b)
    x = x - 0.05*g
    return x
end
Random.seed!(12345);
res1 = @benchmark serial_l1ball(sortscan_s, $(prep_data(data, b, rand(Normal(0,1), i))))
println("Serial Sort and Scan: ", median(res1))
Random.seed!(12345);
res2 = @benchmark parallel_l1ball(sortscan_p, $(prep_data(data, b, rand(Normal(0,1), i))))
println("Parallel Sort and Scan: ", median(res2))
Random.seed!(12345);
res3 = @benchmark parallel_l1ball(sortPscan_p, $(prep_data(data, b, rand(Normal(0,1), i))))
println("Parallel Sort and Partial Scan: ", median(res3))
Random.seed!(12345);
res4 = @benchmark serial_l1ball(michelot_s, $(prep_data(data, b, rand(Normal(0,1), i))))
println("Serial Michelot: ", median(res4))
Random.seed!(12345);
res5 = @benchmark parallel_l1ball(michelot_p, $(prep_data(data, b, rand(Normal(0,1), i))))
println("Parallel Michelot: ", median(res5))
Random.seed!(12345);
res6 = @benchmark serial_l1ball(condat_s, $(prep_data(data, b, rand(Normal(0,1), i))))
println("Serial Condat: ", median(res6))
Random.seed!(12345);
res7 = @benchmark parallel_l1ball(condat_p, $(prep_data(data, b, rand(Normal(0,1), i))))
println("Parallel Condat: ", median(res7))
