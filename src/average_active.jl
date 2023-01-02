using Random, Distributions, BenchmarkTools, Plots
#import PyPlot
#pyplot()

"""
    test_active(data, a)
For an input vector `data`, this function return how many terms will be active
in projecting results.

# Arguments
- `data::AbstractVector`: the original vector you want to project
- `a::Int = 1`: the scaling factor of the simplex
```
"""
function test_active(data::AbstractVector, a::Int =1)::Int
    let
        #imitate sort and scan to calculate how many active terms
        y = sort(data; alg = QuickSort, rev = true)
        #checking process
        l = length(data)
        p = 0
        s = 0
        for i in 1:l
            s += y[i]
            if (s-a)/i > y[i]
                p = i-1
                break
            end
        end
        return p
    end
end

"""
    average_active()
Calculate average number of active terms for different vector sizes
"""
function average_active()
    let
        #initialize a vector to store results
        res = zeros(19)

        order = 1
        for i in 1:0.5:10
            #n is samples size
            n = Int(i*1000000)
            #set random seed
            Random.seed!(1234);
            #s is summation
            s = 0
            #repeat 10 times
            for j in 1:10
                data = rand(n)
                s += test_active(data, 1)
            end
            res[order] = (s/10)
            order += 1
        end
        return res
    end
end
#result for average number of active terms
res1=average_active();
#value of sqrt(2n)
res=10^6:5*10^5:10^7
res2=zeros(19)
for i in 1:19
    res2[i]=(2res[i])^(0.5)
end

#plot figure
plot(10^6:5*10^5:10^7,res1, linewidth=1, label="observed average", line = (:blue,1,:scatter), xlabel = "input size n",
       ylabel ="active elements",legend=:topleft)
plot!(10^6:5*10^5:10^7,res2,label="estimate", line=(:orange, 1, 1))
savefig("average_active.png")
println("Note: generate a new figure named average_active.png")
