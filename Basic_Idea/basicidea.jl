#=
This script implements a basic idea for parallel projection onto the probability simplex. The idea includes parallel sort (Usually, we use mergesort for shared 
arrary.) and parallel scan to find the τ. For the parallel scan, prefix sum is a general idea. But we want to get the summations of previous n entries in order, 
while prefix sum does not generate the partial summations in order, so we try another method to implement parallel scan.
=#
using ThreadsX
using BenchmarkTools
using Base.Threads

#foo1 is the function does not use the multiple threads
function foo1(data,a)
    N=length(data)
    y=sort(data;alg=QuickSort,rev=true) #
    global s=0
    for i in 1:N
        global s
        s=s+y[i]
        if (s[i]-a)/i >y[i]
            global p=i-1
            break
        end
    end
    return p
end

#foo2 is the function use parallel sort and prefix sum
function foo2(data,a)
    N=length(data) #the size of input data
    #use this one to sort the input data
    y=sort(data;alg=ThreadsX.MergeSort,rev=true)
    s=copy(y)
    prefix_threads!(s)
    for i in 1:N
        if (s[i]-a)/i > y[i]
            global p=i-1
            break
        end
    end
    return p
end


#foo3 is the function use the parallel sort and my parallel scan
function foo3(data,a)
    N=length(data) #the size of input data
    #use this one to sort the input data
    y=sort(data;alg=ThreadsX.MergeSort,rev=true)
    p=mypscan(y,a)
    return p
end
