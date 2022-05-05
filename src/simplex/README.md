# Simplex
Include three folders,
- Sort and Scan method,
- Michelot method,
- Condat method.

Each folder includes corresponding serial algorithm, parallel algorithm, and a projection operation tool.

Tow testing files:
## benchmark_test.jl
Using @benchmark to test seven methods in three distributions, <img src="https://render.githubusercontent.com/render/math?math=\large U[0,1]">, <img src="https://render.githubusercontent.com/render/math?math=\large N[0,1]">, and <img src="https://render.githubusercontent.com/render/math?math=\large N[0,10^{-3}]"> with sample sizes <img src="https://render.githubusercontent.com/render/math?math=\large n=10^5,5\times 10^5,...,10^8">.

## robustness_test.jl
Using @benchmark to test seven methods in three task with fixed sample size <img src="https://render.githubusercontent.com/render/math?math=\large n=10^6">.

### task 1: unit vector
All but one terms of a vector are zeros, and the remaining one terms is 1.

### task 2: large b
Let 
