#serial_scan.jl
"""
    serial_scan(y,a)

Scan `y` to remove little terms until all remaining elements are active in
    projection onto scaling standard simplex with scaling factor `a`.

# Arguments
- `y::AbstractVector`: the vector you want to scan
- `a::Int = 1`: the scaling factor for the scaling standard simplex

# Examples
```julia-repl
julia> serial_scan([1,1],1)
0.5
```
"""
function serial_scan(y::AbstractVector, a::Real = 1)::AbstractFloat
    #initialize pivot
    p = (sum(y)-a)/length(y)
    while true
        #record current lengthe
        l = length(y)
        #check all terms in current y
        for i in 1:l
            x = popfirst!(y)
            #remove inactive terms
            if x > p
                push!(y,x)
            end
        end
        #update pivot
        p=(sum(y)-a)/length(y)
        #check stop criteria
        if l == length(y)
            return p
        end
    end
end
