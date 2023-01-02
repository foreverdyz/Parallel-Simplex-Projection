#lasso.jl
"""
    lasso_serial(A, b, x0, a, f)
Solve Lasso problem with underlying simplex projection method `f`.

# Notations
You can change `f` to use different simplex methods.

# Arguments
- `A::AbstractArray`: matrix A
- `b::AbstractVector`: vector b
- `x0::AbstractVector`: initial point x0
- `a::Real =1`: the scaling factor of the l1 ball in Lasso constraint
- `f::Function`: the simplex project method you want to use
```
"""
function lasso_serial(A::AbstractArray, b::AbstractVector, x0::AbstractVector, a::Real = 1, f::Function)
    let
        x=x0
        #stepsize
        α=0.05 # setpsize α can be 0.05 or 0.01, and in our paper, 0.01 for lasso_benchmark.jl and 0.05 for lasso_realdata.jl
        #iteration number
        i=0
        while i < 10
            #gradients
            g= A'*(A*x+b)
            #update x
            x_new=x-α*g
            #project back to
            if sum(abs.(x_new))>1
                xnew=serial_l1ball(f,x_new, a)
            end
            i=i+1
            #termination condition
            if (x-xnew)'*(x-xnew)<1
                return xnew
            end
            x=xnew
        end
        return x
    end
end

"""
    lasso_parallel(A, b, x0, a, f)
Solve Lasso problem with underlying parallel simplex projection method `f`.

# Notations
You can change `f` to use different simplex methods.

# Arguments
- `A::AbstractArray`: matrix A
- `b::AbstractVector`: vector b
- `x0::AbstractVector`: initial point x0
- `a::Real =1`: the scaling factor of the l1 ball in Lasso constraint
- `f::Function`: the simplex project method you want to use
```
"""
function lasso_parallel(A,::AbstractArray b::AbstractVector, x0::AbstractVector, a::Real = 1, f::Function)
    let
        x=x0
        α=0.05 # setpsize α can be 0.05 or 0.01
        i=0
        while i < 10
            g= A'*(A*x+b)
            x_new=x-α*g
            if sum(abs.(x_new))>1
                xnew=parallel_l1ball(f,x_new, a)
            end
            i=i+1
            if (x-xnew)'*(x-xnew)<1
                return xnew
            end
            x=xnew
        end
        return x
    end
end
