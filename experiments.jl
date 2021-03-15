#this script contains some experiments for the 3 functions in the
#basic idea script
using Random, Distributions
using BenchmarkTools
using Base.Threads

function showcmp()
    println("foo2 vs foo1")
    display(judge(mean(res2),mean(res1)))
    println("foo3 vs foo1")
    display(judge(mean(res3),mean(res1)))
end

println("The number of threads is ", nthreads())

#Trail 1, data comes from uniform distributions, a=rand()*N/10
println("Trail 1 with uniform distribution.")
res1=@benchmark foo1(rand(10_000),rand()*5_000)
res2=@benchmark foo2(rand(10_000),rand()*5_000)
res3=@benchmark foo3(rand(10_000),rand()*5_000)

println("With rand(10_000) data,")

showcmp()

res1=@benchmark foo1(rand(100_000),rand()*50_000)
res2=@benchmark foo2(rand(100_000),rand()*50_000)
res3=@benchmark foo3(rand(100_000),rand()*50_000)

println("With rand(100_000) data,")

showcmp()

res1=@benchmark foo1(rand(1_000_000),rand()*500_000)
res2=@benchmark foo2(rand(1_000_000),rand()*500_000)
res3=@benchmark foo3(rand(1_000_000),rand()*500_000)

println("With rand(1_000_000) data")

showcmp()

res1=@benchmark foo1(rand(10_000_000),rand()*5_000_000)
res2=@benchmark foo2(rand(10_000_000),rand()*5_000_000)
res3=@benchmark foo3(rand(10_000_000),rand()*5_000_000)

println("With rand(10_000_000) data")

showcmp()



#Trail 2, data comes from standard norm distribution, a is rand()-0.5

println("Trail 2 with norm distribution.")
res1=@benchmark foo1(rand(Normal(0,1),10_000),rand()-0.5)
res2=@benchmark foo2(rand(Normal(0,1),10_000),rand()-0.5)
res3=@benchmark foo3(rand(Normal(0,1),10_000),rand()-0.5)

println("With rand(Normal(0,1),10_000) data,")

showcmp()


res1=@benchmark foo1(rand(Normal(0,1),100_000),rand()-0.5)
res2=@benchmark foo2(rand(Normal(0,1),100_000),rand()-0.5)
res3=@benchmark foo3(rand(Normal(0,1),100_000),rand()-0.5)

println("With rand(Normal(0,1),100_000) data,")

showcmp()


res1=@benchmark foo1(rand(Normal(0,1),1_000_000),rand()-0.5)
res2=@benchmark foo2(rand(Normal(0,1),1_000_000),rand()-0.5)
res3=@benchmark foo3(rand(Normal(0,1),1_000_000),rand()-0.5)

println("With rand(Normal(0,1),1_000_000) data,")

showcmp()


res1=@benchmark foo1(rand(Normal(0,1),10_000_000),rand()-0.5)
res2=@benchmark foo2(rand(Normal(0,1),10_000_000),rand()-0.5)
res3=@benchmark foo3(rand(Normal(0,1),10_000_000),rand()-0.5)

println("With rand(Normal(0,1),10_000_000) data,")

showcmp()


#Trial 3, data comes from the exponential distributions

res1=@benchmark foo1(rand(Exponential(10),10_000),rand()*1_000)
res2=@benchmark foo2(rand(Exponential(10),10_000),rand()*1_000)
res3=@benchmark foo3(rand(Exponential(10),10_000),rand()*1_000)

println("With rand(Exponential(10),10_000) data,")

showcmp()


res1=@benchmark foo1(rand(Exponential(10),100_000),rand()*10_000)
res2=@benchmark foo2(rand(Exponential(10),100_000),rand()*10_000)
res3=@benchmark foo3(rand(Exponential(10),100_000),rand()*10_000)

println("With rand(Exponential(10),100_000) data,")

showcmp()


res1=@benchmark foo1(rand(Exponential(10),1_000_000),rand()*100_000)
res2=@benchmark foo2(rand(Exponential(10),1_000_000),rand()*100_000)
res3=@benchmark foo3(rand(Exponential(10),1_000_000),rand()*100_000)

println("With rand(Exponential(10),1_000_000) data,")

showcmp()


res1=@benchmark foo1(rand(Exponential(10),10_000_000),rand()*100_000)
res2=@benchmark foo2(rand(Exponential(10),10_000_000),rand()*100_000)
res3=@benchmark foo3(rand(Exponential(10),10_000_000),rand()*100_000)

println("With rand(Exponential(10),10_000_000) data,")

showcmp()
