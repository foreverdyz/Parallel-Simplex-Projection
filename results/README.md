# Replicating Plost in [results](results)

We organize this tutorial by the type of projections.

## Projection onto a simplex

Run the script simplex_runtim_benchmark.jl in [src](src) with 80 cores (you can change the number of cores in the script based on your device), you can get runtime results for
- input vector $d$ with size of $10^8$ and distributions $U[0,1], N(0,1), N(0, 0.001)$; then you can get the plots: simplex_norm_comp.png, simplex_unif_comp.png, simplex_small_norm_comp.png, simplex_sortscan.png, simplex_michelot.png, simplex_condat.png;
- input vector with distribution $N(0,1)$ and size of $10^7, 10^8, 10^9$; then you can get the plots: simplex_107_comp.png, simplex_108_comp.png, simplex_109_comp.png, ss_mlen.png, sps_mlen.png, michelot_mlen.png, condat_mlen.png

## Projection onto an l1 ball

Run the script l1ball_runtime_benchmark.jl in [src](src) with 80 cores, you can get runtime results for input vector $d$ with the size of $10^8$ and distribution $N(0,1)$; then you can get the plots: l1ball_comp.png, l1ball.png

## Projections onto a weighted simplex

Run the script wsimplex_runtime_benchmark in [src](src) with 80 cores, you can get runtime results for input vector $d$ with the size of $10^8$ and distribution $N(0,1)$, and weight $w$ in $U[0,1]$; then you can get the plots: wsimplex_comp.png, wsimplex.png

## Projections onto a weighted l1 ball

Run the script l1ball_runtime_benchmark in [src](src) with 80 cores, you can get runtime results for input vector $d$ with the size of $10^8$ and distribution $N(0,1)$, and weight $w$ in $U[0,1]$; then you can get the plots: wl1ball_comp.png, wl1ball.png

## Projection onto a parity polytope

Run the script paritypolytope_runtime_benchmark in [src](src) with 80 cores, you can get runtime results for input vector $d$ with the size of $10^8-1$ and distribution $U[1,2]$; then you can get the plots: ppproject_comp.png, ppproject.png, pptotal_comp.png, pptotal.png.

## Lasso on real-world data

Run the script real_data_kdd10.jl and real_data_kdd12.jl in [src](src) with 80 cores, you can get runtime results for Lasso in [kdd2010](https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary.html#kdd2010%20(algebra)) and [kdd2012](https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary.html#kdd2012); then you can get the plots: kdd2010_comp.png, kdd2010.png, kdd2012_comp.png, kdd2012.png.
