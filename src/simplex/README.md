# Simplex
Include three folders,
- Sort and Scan method,
- Michelot method,
- Condat method.

Each folder includes corresponding serial algorithm, parallel algorithm, and a projection operation tool.

Tow testing files:
## benchmark_test.jl
using @benchmark to test seven methods in three distributions, U[0,1], N[0,1], and N[0,0.001] with sample sizes from 10^5 to 10^8.
