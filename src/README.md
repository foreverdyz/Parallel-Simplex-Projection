# src

## Simplex
This folder includes
- three known methods to project onto a scaled standard simplex, both serial and parallel versions;
- a general algorithm to calculate ![formula](https://render.githubusercontent.com/render/math?math=v^*) by pivot and original vector ![formula](https://render.githubusercontent.com/render/math?math=d) ;
- a benchmark test script for these methods.

## ![formula](https://render.githubusercontent.com/render/math?math=\ell_1) ball

### l1ball.jl
Define two projection templetes for ![formula](https://render.githubusercontent.com/render/math?math=\ell_1) ball. You can use simplex projection methods to replace ![formula](https://render.githubusercontent.com/render/math?math=f) in function argument.

### l1ball_benchmark.jl
Use @benchmark to test ![formula](https://render.githubusercontent.com/render/math?math=\ell_1) ball projections. There are two results, res1 is the runtime for ![formula](https://render.githubusercontent.com/render/math?math=\ell_1) ball projection, and res2 is the runtime for the subroutine, projecting absolute values of input onto simplex.

## Parity Polytope

### parity.jl
Define two projection templetes for parity polytope. You can use simplex projection methods to replace ![formula](https://render.githubusercontent.com/render/math?math=fun) in function argument.

### parity_benchmark.jl
Use @benchmark to test parity polytope projections. There are two results, res1 is the runtime for parity polytope projection, and res2 is the runtime for the subroutine, projecting input onto simplex.


## Weighted Simplex & Weighted ![formula](https://render.githubusercontent.com/render/math?math=\ell_1) ball
