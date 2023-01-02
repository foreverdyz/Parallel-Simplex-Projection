#required_modules.jl
#import customer modules
import Pkg;
Pkg.add("BenchmarkTools")
Pkg.add("Random")
Pkg.add("Distributions")
Pkg.add("ThreadsX")
Pkg.add("Plots")
Pkg.add("BangBang")
#Pkg.add("PyPlot")
using BenchmarkTools
using Random
using Distributions
using ThreadsX
using Plots
using BangBang
#import PyPlot

#import our simplex projection modules
include("simplex/sort and scan/sortscanModule.jl")
include("simplex/michelot/michelotModule.jl")
include("simplex/condat/condatModule.jl")
using .sortscan
using .michelot
using .condat

#import our weighted simplex projection modules
include("weighted/weighted simplex/wsimplexModule.jl")
using. wsimplex
