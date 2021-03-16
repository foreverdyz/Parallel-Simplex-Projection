#this script contains some experiments for the 3 functions in the
#basic idea script
using Random, Distributions
using BenchmarkTools
using Base.Threads

function showcmp()
    println("foo2 vs foo1")
    write(io,"foo2 vs foo1\n")
    cmp1=judge(mean(res2),mean(res1))
    display(cmp1)
    write(io, "$cmp1\n");
    println("foo3 vs foo1")
    write(io,"foo3 vs foo1\n")
    cmp2=judge(mean(res3),mean(res1))
    display(cmp2)
    write(io, "$cmp2\n");
end

function showtime_memory()
    mean1=mean(res1)
    print("foo1: ")
    display(mean1)
    write(io,"foo1: ")
    write(io, "$mean1\n");
    mean2=mean(res2)
    print("foo2: ")
    display(mean2)
    write(io,"foo2: ")
    write(io, "$mean2\n");
    mean3=mean(res3)
    print("foo3: ")
    display(mean3)
    write(io,"foo3: ")
    write(io, "$mean3\n");
end

io = open("experiements_basic.txt", "a");
num=nthreads()
#Trail 1, data comes from uniform distributions, a=rand()*N/10
println("The number of threads is ", nthreads())
println("Trail 1 with uniform distribution.")
write(io, "###################################\n");
write(io, "\n");
write(io, "###################################\n");
write(io, "The number of threads is $num\n");
write(io, "===================================\n");
write(io, "Trail 1 with uniform distribution.\n");
write(io, "\n");
res1=@benchmark foo1(rand(10_000),rand()*10_000)
res2=@benchmark foo2(rand(10_000),rand()*10_000)
res3=@benchmark foo3(rand(10_000),rand()*10_000)
write(io, "\n");
println("With rand(10_000) data,")
write(io, "With rand(10_000) data,\n");
showtime_memory()

res1=@benchmark foo1(rand(100_000),rand()*100_000)
res2=@benchmark foo2(rand(100_000),rand()*100_000)
res3=@benchmark foo3(rand(100_000),rand()*100_000)
write(io, "\n");
println("With rand(100_000) data,")
write(io, "With rand(100_000) data,\n");
showtime_memory()

res1=@benchmark foo1(rand(1_000_000),rand()*1_000_000)
res2=@benchmark foo2(rand(1_000_000),rand()*1_000_000)
res3=@benchmark foo3(rand(1_000_000),rand()*1_000_000)
write(io, "\n");
println("With rand(1_000_000) data")
write(io, "With rand(1_000_000) data,\n");
showtime_memory()

res1=@benchmark foo1(rand(10_000_000),rand()*10_000_000)
res2=@benchmark foo2(rand(10_000_000),rand()*10_000_000)
res3=@benchmark foo3(rand(10_000_000),rand()*10_000_000)
write(io, "\n");
println("With rand(10_000_000) data")
write(io, "With rand(10_000_000) data,\n");
showtime_memory()
write(io, "===================================\n");
write(io,"\n");

#Trail 2, data comes from norm distribution, a is rand()-0.5
println("The number of threads is ", nthreads())
println("Trail 2 with norm distribution.")
write(io, "\n");
write(io, "The number of threads is $num\n");
write(io, "===================================\n");
write(io, "Trail 2 with norm distribution.\n");
write(io, "\n");

res1=@benchmark foo1(rand(Normal(1,1),10_000),rand()*10_000)
res2=@benchmark foo2(rand(Normal(1,1),10_000),rand()*10_000)
res3=@benchmark foo3(rand(Normal(1,1),10_000),rand()*10_000)
write(io, "\n");
println("With rand(Normal(1,1),10_000) data,")
write(io, "With rand(Normal(1,1),10_000) data,\n");
showtime_memory()


res1=@benchmark foo1(rand(Normal(1,1),100_000),rand()*100_000)
res2=@benchmark foo2(rand(Normal(1,1),100_000),rand()*100_000)
res3=@benchmark foo3(rand(Normal(1,1),100_000),rand()*100_000)
write(io, "\n");
println("With rand(Normal(1,1),100_000) data,")
write(io, "With rand(Normal(1,1),100_000) data,\n");
showtime_memory()


res1=@benchmark foo1(rand(Normal(1,1),1_000_000),rand()*1_000_000)
res2=@benchmark foo2(rand(Normal(1,1),1_000_000),rand()*1_000_000)
res3=@benchmark foo3(rand(Normal(1,1),1_000_000),rand()*1_000_000)
write(io, "\n");
println("With rand(Normal(1,1),1_000_000) data,")
write(io, "With rand(Normal(1,1),1_000_000) data,\n");
showtime_memory()


res1=@benchmark foo1(rand(Normal(1,1),10_000_000),rand()*10_000_000)
res2=@benchmark foo2(rand(Normal(1,1),10_000_000),rand()*10_000_000)
res3=@benchmark foo3(rand(Normal(1,1),10_000_000),rand()*10_000_000)
write(io, "\n");
println("With rand(Normal(1,1),10_000_000) data,")
write(io, "With rand(Normal(1,1),10_000_000) data,\n");
showtime_memory()
write(io, "===================================\n");
write(io,"\n");

#Trial 3, data comes from the exponential distributions
println("The number of threads is ", nthreads())
println("Trail 3 with exponential distribution.")
write(io, "\n");
write(io, "The number of threads is $num\n");
write(io, "===================================\n");
write(io, "Trail 3 with exponential distribution.\n");
write(io, "\n");

res1=@benchmark foo1(rand(Exponential(10),10_000),rand()*1000)
res2=@benchmark foo2(rand(Exponential(10),10_000),rand()*1000)
res3=@benchmark foo3(rand(Exponential(10),10_000),rand()*1000)
write(io, "\n");
println("With rand(Exponential(10),10_000) data,")
write(io, "With rand(Exponential(10),10_000) data,\n");
showtime_memory()


res1=@benchmark foo1(rand(Exponential(10),100_000),rand()*10_000)
res2=@benchmark foo2(rand(Exponential(10),100_000),rand()*10_000)
res3=@benchmark foo3(rand(Exponential(10),100_000),rand()*10_000)
write(io, "\n");
println("With rand(Exponential(10),100_000) data,")
write(io, "With rand(Exponential(10),100_000) data,\n");
showtime_memory()


res1=@benchmark foo1(rand(Exponential(10),1_000_000),rand()*100_000)
res2=@benchmark foo2(rand(Exponential(10),1_000_000),rand()*100_000)
res3=@benchmark foo3(rand(Exponential(10),1_000_000),rand()*100_000)
write(io, "\n");
println("With rand(Exponential(10),1_000_000) data,")
write(io, "With rand(Exponential(10),1_000_000) data,\n");
showtime_memory()


res1=@benchmark foo1(rand(Exponential(10),10_000_000),rand()*1_000_000)
res2=@benchmark foo2(rand(Exponential(10),10_000_000),rand()*1_000_000)
res3=@benchmark foo3(rand(Exponential(10),10_000_000),rand()*1_000_000)
write(io, "\n");
println("With rand(Exponential(10),10_000_000) data,")
write(io, "With rand(Exponential(10),10_000_000) data,\n");
showtime_memory()
write(io, "===================================\n");
write(io,"\n");

close(io)
