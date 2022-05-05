# Simplex
Include three folders,
- Sort and Scan method,
- Michelot method,
- Condat method.

Each folder includes corresponding serial algorithm, parallel algorithm, and a projection operation tool.

Tow testing files:
## benchmark_test.jl
Using @benchmark to test seven methods in three distributions, ![formula](https://render.githubusercontent.com/render/math?math=U[0,1]), ![formula]![formula](https://render.githubusercontent.com/render/math?math=N(0,1)), and ![formula](https://render.githubusercontent.com/render/math?math=N(0,10^{-3})) with sample sizes ![formula](https://render.githubusercontent.com/render/math?math=n=10^5,...,10^8).

## robustness_test.jl
Using @benchmark to test seven methods in three task with fixed sample size ![formula](https://render.githubusercontent.com/render/math?math=n=10^6).

### task 1: unit vector
All but one terms of a vector are zeros, and the remaining one terms is 1.

### task 2: large b
Let ![formula](img src="https://render.githubusercontent.com/render/math?math=\large b=8\}"), where ![formula](img src="https://render.githubusercontent.com/render/math?math=\large b\}") is from ![formula](img src="https://render.githubusercontent.com/render/math?math=\large \Delta_b:=\{v\in\mathbb{R}^n\ |\ \sum_{i=1}^{n}v_i=b\}").

### task 3: outlier data
A vector includes ![formula](img src="https://render.githubusercontent.com/render/math?math=\large n-1\}") elements are from ![formula](img src="https://render.githubusercontent.com/render/math?math=\large N(0,10^{-3})\}") and the other one term is 1.
