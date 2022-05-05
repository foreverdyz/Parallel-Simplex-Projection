# Parallel Simplex Projection

[Paper Link](https://arxiv.org/pdf/2204.08153)

##  Parallelization of Projection onto a Simplex

Consider a scaled standard simplex with scaling factor <img src="https://render.githubusercontent.com/render/math?math=\large b">,

<img src="https://render.githubusercontent.com/render/math?math=\large \Delta_b:=\{v\in\mathbb{R}^n\ |\ \sum_{i=1}^{n}v_i=b\}">;

we want to porject a vector <img src="https://render.githubusercontent.com/render/math?math=\large d"> onto such simplex. There have been some known method, e.g. [SortScan](https://link.springer.com/article/10.1007/BF01580223), [Pivot](https://dl.acm.org/doi/abs/10.1145/1390156.1390191), [Michelot](https://dl.acm.org/doi/abs/10.5555/3228358.3228653), [Condat](https://link.springer.com/article/10.1007/s10107-015-0946-6), [Bucket](https://link.springer.com/article/10.1007/s10107-019-01401-3), etc.

We propose a distributed structure to parallel simplex projection, and develop parallel methods based on some known serial algorithms. Our contributions includes:
- modify an existing parallel method developed by [Wasson et al.](https://ieeexplore.ieee.org/document/8768221);
- do some theoretical analysis including supplying average complexity to some known serial methods, showing the sparsity of simplex projection, etc.;
- on the ground of our theoretical work, we propose a distributed structure for simplex projection;
- apply novel structure to parallelize some known serial algorithms, see e.g. [Michelot](https://dl.acm.org/doi/abs/10.5555/3228358.3228653), [Condat](https://link.springer.com/article/10.1007/s10107-015-0946-6), etc.;
- analyze complexity for these new parallel algorithms.

## Extension of Simplex Projection

There are some projections onto other polyhedra can leverage projection onto a scaled standard simplex:
- <img src="https://render.githubusercontent.com/render/math?math=\ell_1"> ball;
- parity polytope;
- weighted simplex and weighted <img src="https://render.githubusercontent.com/render/math?math=\ell_1"> ball;

### Some Applications

- LASSO, which we implement Projected Gradient Descent (PGD) algorithm to solve Lasso problem;
  
