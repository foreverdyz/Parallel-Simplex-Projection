# Src

## Simplex
This folder includes
- three known methods to project onto a scaled standard simplex, both serial and parallel versions;
- a general algorithm to calculate ![formula](https://render.githubusercontent.com/render/math?math=v^*) by pivot and original vector ![formula](https://render.githubusercontent.com/render/math?math=d) ;
- a benchmark test script for these methods.

## benchmark_l1ball.jl
This script test projections ![formula](https://render.githubusercontent.com/render/math?math=|d|) onto a scaled standard simple, which is a cricurial step in projection onto ![formula](https://render.githubusercontent.com/render/math?math=\ell_1) ball with methods from Simplex folder.
