# Parallel Simplex Projection

##  Parallel Algorithm for Projection onto a Simplex

[Project Link](https://github.com/foreverdyz/Parallel-Simplex-Projection)

Consider a standard scaling simplex with scaling factor <img src="https://render.githubusercontent.com/render/math?math=b">,
```math
\Delta_b:=\{v\in\mathbb{R}^n\ |\ \sum_{i=1}^{n}v_i=b\};
```
we want to porject a vector $d$ onto such simplex. There have been some known method, e.g.

We propose a distributed structure to parallel simplex projection, and develop parallel methods based on some known serial algorithms. Our contributions includes:
- modify an existing parallel method developed by [Wasson et al.](https://ieeexplore.ieee.org/document/8768221);
- do some theoretical analysis including supplying average complexity to some known serial methods, showing the sparsity of simplex projection, etc.;
- on the ground of our theoretical work, we propose a distributed structure for simplex projection;
- apply novel structure to parallelize some known serial algorithms, see like [Michelot](https://dl.acm.org/doi/abs/10.5555/3228358.3228653), [Condat](https://link.springer.com/article/10.1007/s10107-015-0946-6), etc.;
- analyze complexity for these new parallel algorithms.
