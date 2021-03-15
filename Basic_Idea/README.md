The basic idea for projection onto the probability simplex is sort the vector as y, then find the max k={\sum_{i=1}^{k} y_{i} - a \leq k * y_{k}}.

It is easy to implement it, like foo1().

Now, we parallize it with parallel mergesort and prefix sum as foo2().

But prefix sum will be suboptimal in some extreme situations like the k=1, so we implement a higher efficient parallel scan algorithms as mypscan(). With the new scan method, we gain foo3().
