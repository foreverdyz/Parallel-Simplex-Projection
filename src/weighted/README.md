# weighted-simplex
This folder includes 
- three weighted simplex projection methods for both serial and parallel, which are analugous to simplex projection methods;
- benchmark tests scripts for these methdos.

# weighted_l1ball.jl
Two projection templates for weighted ![formula](https://render.githubusercontent.com/render/math?math=\ell_1) ball projection. You can use different weighted simplex projection methods to replace argument f.

# wl1ball_benchmark.jl
Use @benchmark to test six methods to weighted ![formula](https://render.githubusercontent.com/render/math?math=\ell_1) ball projection in input data from ![formula](https://render.githubusercontent.com/render/math?math=N(0,1)) and weight from ![formula](https://render.githubusercontent.com/render/math?math=U[0,1]) with sample sizes ![formula](https://render.githubusercontent.com/render/math?math=n=10^5,....,10^7).
