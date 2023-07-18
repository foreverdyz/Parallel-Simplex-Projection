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
#import PyPlots
