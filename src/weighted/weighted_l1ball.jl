#weighted_l1ball.jl

using Base.Threads

"""
    serial_wl1ball(f,data,a)
    parallel_wl1ball(f,data,a)
Project `data` onto weighted l1 ball with scaling factor `a`. `f` is the underlying
weighted simplex projection method used to finish the weighted l1 ball projection.

# Notations
Change function method `f` to use different simplex projection methods

# Arguments
- `f::Function`: the simplex projection method you want to use
- `data::AbstractVector`: the original vector you want to project
- `a::Int = 1`: the scaling factor of the l1 ball
```
"""
function serial_wl1ball(f::Function, data::AbstractVector, w::AbstractVector, a::Int = 1)::AbstractVector
    #project absolute value of data onto a weighted simplex
    y = f(abs.(data), w, a)
    #give back signs of data
    for i in 1:length(data)
        if data[i] < 0
            y[i] = -y[i]
        end
    end
    #output projection result
    return y
end

function parallel_wl1ball(f::Function, data::AbstractVector, w::AbstractVector, a::Int = 1)::AbstractVector
    y = f(abs.(data), w, a)
    @threads for i in 1:length(data)
        if data[i] < 0
            @inbounds y[i] = -y[i]
        end
    end
    return y
end
