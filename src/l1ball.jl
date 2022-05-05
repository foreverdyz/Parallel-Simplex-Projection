#l1ball.jl
using Base.Threads
"""
    serial_l1ball(f,data,a)
    parallel_l1ball(f,data,a)
Project `data` onto l1 ball with scaling factor `a`. `f` is the underlying
simplex projection method used to finish the l1 ball projection.

# Notations
Change function method `f` to use different simplex projection methods

# Arguments
- `f::Function`: the simplex projection method you want to use
- `data::AbstractVector`: the original vector you want to project
- `a::Int = 1`: the scaling factor of the l1 ball
```
"""
function serial_l1ball(f::Function, data::AbstractVector, a::Int = 1)::AbstractVector
    let
        #project abs.(data) onto simplex
        y = f(abs.(data), a)
        #give back the sign of data
        for i in 1:length(data)
            if data[i] < 0
                y[i] = -y[i]
            end
        end
        return y
    end
end

function parallel_l1ball(f::Function, data::AbstractVector, a::Int = 1)::AbstractVector
    let
        #project abs.(data) onto simplex
        y = f(abs.(data), a)
        #give back the sign of data
        @threads for i in 1:length(data)
            if data[i] < 0
                y[i] = -y[i]
            end
        end
        return y
    end
end
