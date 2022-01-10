using ThreadsX
using BenchmarkTools
using Base.Threads
include("prefix_threads!.jl")

function sortscan_w(data,w,a)
    let
        l=length(data)
        y=[]
        for i in 1:l
            push!(y,[data[i]/w[i],data[i],w[i]])
        end
        y=sort(y;alg=QuickSort,rev=true)
        s1=0
        s2=0
        p=0
        for i in 1:l
            s1+=y[i][2]*y[i][3]
            s2+=y[i][3]^2
            if (s1-a)/s2>=y[i][2]/y[i][3]
                p=(s1-y[i][2]*y[i][3]-a)/(s2-y[i][3]^2)
                break
            end
        end
        x=zeros(l)
        for i in 1:l
            if data[i]>w[i]*p
                x[i]=data[i]-w[i]*p
            end
        end
        return x
    end
end

function psortscan_w(data,w,a)
    let
        l=length(data)
        y=[]
        for i in 1:l
            push!(y,[data[i]/w[i],data[i],w[i]])
        end
        y=sort(y;alg=ThreadsX.MergeSort,rev=true)
        x1=zeros(l)
        x2=zeros(l)
        for i in 1:l
            x1[i]=y[i][2]*y[i][3]
            x2[i]=y[i][3]^2
        end
        prefix_threads!(x1)
        prefix_threads!(x2)
        p=0
        for i in 1:l
            if ((x1[i]-a)/x2[i])>=y[i][1]
                p=(x1[i-1]-a)/x2[i-1]
                break
            end
        end
        x=zeros(l)
        @threads for i in 1:l
            if data[i]>w[i]*p
                x[i]=data[i]-w[i]*p
            end
        end
        return x
    end
end
