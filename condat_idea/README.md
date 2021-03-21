This folder contains algorithms based on Condat's idea. Condat proposes a new projection method in 
Condat, L. Fast projection onto the simplex and the 𝑙𝑙1 ball. Math. Program. 158, 575–585 (2016). https://doi.org/10.1007/s10107-015-0946-6.

We try to parallelize this idea with some necessary changes. Then, we compare parallel algorithm with the original one.

Note: when the length of the vector is not greater than 10,000, we use the serial algorithm instead of the parallization.
