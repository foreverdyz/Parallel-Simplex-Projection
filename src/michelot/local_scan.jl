#local_scan.jl

"""
    local_scan(y,a)

Scan `y` to remove little terms until all remaining elements are active in
    projection onto scaling standard simplex with scaling factor `a`.

# Arguments
- `y::AbstractVector`: the vector you want to scan
- `a::Int = 1`: the scaling factor for the scaling standard simplex

# Examples
```julia-repl
julia> serial_scan([1,1,0],1)
[1,1]
```
"""
function local_scan(y::AbstractVector, a::Int = 1)::AbstractVector
    (l = length(y))::Int
    (p = (sum(y)-a)/l)::AbstractFloat
    while true
        for i in 1:l
            if (x=popfirst!(y))>p
                push!(y,x)
            end
        end
        if (lnew=length(y))==l
            return y
        end
        p=(sum(y)-a)/(l=lnew)
    end
end
