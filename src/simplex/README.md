# Simplex
Include three folders,
- Sort and Scan method,
- Michelot method,
- Condat method.

Each folder includes corresponding serial algorithm, parallel algorithm, and a projection operation tool.

Tow testing files:
## benchmark_test.jl
using @benchmark to test seven methods in three distributions, <img src="https://render.githubusercontent.com/render/math?math=\large U[0,1]">, <img src="https://render.githubusercontent.com/render/math?math=\large N[0,1]">, and <img src="https://render.githubusercontent.com/render/math?math=\large N[0,10^{-3}]"> with sample sizes from <img src="https://render.githubusercontent.com/render/math?math=\large n=10^5,5\times 10^5,...,10^8">.
