[![INFORMS Journal on Computing Logo](https://INFORMSJoC.github.io/logos/INFORMS_Journal_on_Computing_Header.jpg)](https://pubsonline.informs.org/journal/ijoc)

# Bounds on options prices

This archive is distributed in association with the [INFORMS Journal on
Computing](https://pubsonline.informs.org/journal/ijoc) under the [MIT License](LICENSE).

The software and data in this repository are a snapshot of the software and data
that were used in the research reported on in [Revisiting Semidefinite Programming Approaches to Options Pricing: Complexity and Computational Perspectives](https://doi.org/10.1287/ijoc.2022.1220) by Didier Henrion, Felix Kirschner, Etienne de Klerk, Milan Korda, Jean-Bernard Lasserre and Victor Magron.  See also (https://arxiv.org/abs/2111.07701).


## Cite

To cite this material, please cite this repository, using the following DOI.

[![DOI](https://zenodo.org/badge/497938610.svg)](https://zenodo.org/badge/latestdoi/497938610)

Below is the BibTex for citing this version of the code.

```
@article{OptionsPricing,
  author =        {Didier Henrion, Felix Kirschner, Etienne de Klerk, Milan Korda, Jean-Bernard Lasserre, Victor Magron},
  publisher =     {INFORMS Journal on Computing},
  title =         {{OptionsPricing} Version v1.0},
  year =          {2022},
  doi =           {10.5281/zenodo.6602361},
  url =           {https://github.com/INFORMSJoC/2021.0321},
}  
```

## Background 

An option is a derivative security. There are many kinds of options. We consider European call options, which give the owner of the option the right, but no obligation to purchase a (basket of) stock(s) at a predetermined price, called the strike price, at a predetermined date in the future, called maturity. 


For example, say Alice sells Bob an option on a stock X with strike 100 USD maturing in 2 months time. Two months later, if the current stock price P of X is greater than 100 USD, Bob will exercise the option, meaning Alice has to sell Bob a stock of X for 100 USD. In this case Bob makes a profit of *(P-100)* USD since he can sell the stock at the market for P USD but he only paid 100 USD. If the the date of maturity the price P of the stock is below 100 USD, Bob will not exercise the option since it is cheaper to buy the stock at the stock market. The payoff function for Bob hence is *max(0, x-K)* where *x* is the stock price at maturity and *K* is the strike price. Since Bob's payoff is nonnegative, the option must have a nonnegative value. The code presented here contributes to the question how much an option is worth, which has been studied extensively. 

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
