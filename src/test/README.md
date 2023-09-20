
[![INFORMS Journal on Computing Logo](https://INFORMSJoC.github.io/logos/INFORMS_Journal_on_Computing_Header.jpg)](https://pubsonline.informs.org/journal/ijoc)

# Parallel Simplex Projection

This archive is distributed in association with the [INFORMS Journal on
Computing](https://pubsonline.informs.org/journal/ijoc) under the [MIT License](LICENSE).

The software and data in this repository are a snapshot of the software and data
that were used in the research reported on in [Sparsity-Exploiting Distributed Projections onto a Simplex](https://doi.org/10.1287/ijoc.2022.0328) by Yongzheng Dai and Chen Chen.  See also ([https://arxiv.org/abs/2111.07701](https://arxiv.org/abs/2204.08153)). The snapshot is based on 
[this SHA](https://github.com/tkralphs/JoCTemplate/commit/f7f30c63adbcb0811e5a133e1def696b74f3ba15) 
in the development repository.

**Important: This code is being developed on an on-going basis at
https://github.com/foreverdyz/Parallel-Simplex-Projection. Please go there if you would like to
get a more recent version or would like support**


## Cite

To cite this software, please cite the [paper](https://doi.org/10.1287/ijoc.2022.0328) using its DOI and the software itself, using its DOI.

To cite the contents of this repository, please cite both the paper and this repo, using their respective DOIs.

https://doi.org/10.1287/ijoc.2022.0328

https://doi.org/10.1287/ijoc.2022.0328.cd

Below is the BibTex for citing this snapshot of the respoitory.

```
@article{ParallelSimplexProjection,
  author =        {Y. Dai and C. Chen},
  publisher =     {INFORMS Journal on Computing},
  title =         {{Sparsity-Exploiting Distributed Projections onto a Simplex}},
  year =          {2023},
  doi =           {10.1287/ijoc.2022.0328.cd},
  url =           {https://github.com/INFORMSJoC/2022.0328},
}  
```

## Background 

Projecting a vector onto a simplex is a well-studied problem that arises in a wide range of optimization problems.  Numerous algorithms have been proposed for determining the projection; however, the primary focus of the literature has been on serial algorithms. We present a parallel method that decomposes the input vector and distributes it across multiple processors for local projection. Our method is especially effective when the resulting projection is highly sparse; which is the case, for instance, in large-scale problems with i.i.d. entries. Moreover, the method can be adapted to parallelize a broad range of serial algorithms from the literature. We fill in theoretical gaps in serial algorithm analysis, and develop similar results for our parallel analogues. Numerical experiments conducted on a wide range of large-scale instances, both real-world and simulated, demonstrate the practical effectiveness of the method.  

## Description

Given observable option prices and their respective strikes on various assets {1, ... , n}, we present methods to obtain inner and outer bounds on the feasible range of prices for a European basket call option with given strike relying on the assets {1, ... ,n}. The weights of the basket can be chosen freely. This problem can be stated as a *Generalized Moment Problem (GMP)*; an optimization problem over the space of probability measures. The code we present ought to approximate the optimal solution, i.e., the optimal measure for the GMP, by a hierarchy of semidefinite programs, known as the Lasserre hierarchy. Under suitable assumptions we prove in our [paper](https://arxiv.org/abs/2111.07701), that the hierarchy converges, For a comprehensive treatment of the problem of pricing basket options relying on multiple assets and its mathematical formulation we refer to the [paper](https://arxiv.org/abs/2111.07701). The code presented here was used to obtain all bounds of the examples given in the paper. For the sake of completeness all results that appear in the paper may be found in [results](results).

## Language

The code is written in the [Julia programming language](https://julialang.org). Please visit the website for an installation guide. 

## Required packages 

To run the content of "hierarchy_outer_bounds.jl" in [src](src) the following Julia packages are required: Combinatorics, JuMP, MosekTools, LinearAlgebra.

To install a package simply run

```julia
pkg> add PACKAGE_NAME    # Press ']' to enter the Pkg REPL mode.
```

To run the "example_boyle_lin.jl" file the packages "MomentOpt" and "DynamicPolynomials" are required. For these to function properly some other packages may have to be downgraded. More information on how to do this is to be found in the file "example_boyle_lin.jl".

## Example

To compute outer bounds of the price range of an European basket call option a given strike *K* and observable prices of European call options on the assets {1, ..., n} contained in the basket use the code in *hierarchy_outer_bounds.jl* in [src](src). 

Define a matrix *strikes*, where row *i* contains the prices of the observable options corresponding to asset *i* in ascending order. Further, define a matrix *prices* where the entry *prices[i,j]* contains the price of the option on asset *i* with strike price given by *strikes[i,j]*. 

For example, open the file hierarchy_outer_bounds.jl in your IDE and set

```julia
level = 1

K = 105

B = 400

M = 200000

strikes = [90 95 100 110 120; 90 96 102 107 115]

prices = [20 15.5 12 5.5 1; 20.5 15 10 6 0.75]

weights = [1 / 2 1 / 2]
```
One can check if the given data is consistent by running

```julia
checkConsistency(strikes, prices)
```

If this returns "true" then run

```julia
compBounds(K, B, M, level, silent, strikes, prices, weights)
```

For this particular example the solution is given by: lower bound = 4.625, upper bound = 8.016.



## Results

All results appearing in the paper are collected in [results](results). Information on how to reproduce the results may be found in the README file in the folder [results](results).

## Data 

All data that was used is available in [data](data). Some of the data points were created artificially and some were observed from publicly available data. All data sets are consistent, i.e., do not allow for arbitrage strategies. 
