using Random, Distributions
using BenchmarkTools

function showcmp()
    cmp1=ratio(mean(res2),mean(res1))
    println("foo2 vs foo1: ", cmp1);
    #display(cmp1)
    write(io,"foo2 vs foo1: $cmp1\n");

    cmp2=ratio(mean(res3),mean(res1))
    println("foo3 vs foo1: ", cmp2);
    #display(cmp2)
    write(io,"foo3 vs foo1: $cmp1\n");

    cmp3=ratio(mean(res4),mean(res1))
    println("condat vs foo1: ", cmp3);
    #display(cmp3)
    write(io,"condat vs foo1: $cmp3\n");

    cmp4=ratio(mean(res5),mean(res1))
    println("pcondat vs foo1: ", cmp4);
    #display(cmp4)
    write(io,"pcondat vs foo1: $cmp4\n");
end

function showtime_memory()
    mean1=mean(res1)
    println("foo1: ", mean1);
    #display(mean1)
    write(io,"foo1: $mean1\n");

    mean2=mean(res2)
    println("foo2: ", mean2);
    #display(mean2)
    write(io,"foo2: $mean2\n");

    mean3=mean(res3)
    println("foo3: ", mean3);
    #display(mean3)
    write(io,"foo3: $mean3\n");

    mean4=mean(res4)
    println("condat: ", mean4);
    #display(mean4)
    write(io,"condat: $mean4\n");

    mean5=mean(res5)
    println("pcondat: ", mean5);
    #display(mean5)
    write(io,"pcondat: $mean5\n");
end
#=
#trial 1: uniform distribution with a=1
rng=[10^5,5*10^5,10^6,5*10^6,10^7,5*10^7,10^8]
io = open("experiements_trail_1.txt", "a");
num=nthreads()
println("Trail 1 in uniform distribution with ", num, " threads.")
write(io, "#####################################################\n");
write(io, "Trail 1 in uniform distribution with $num threads.\n")
for i in rng
    global n, res1, res2, res3, res4, res5
    n=i
    Random.seed!(1234);
    res1=@benchmark foo1(rand(n),1)
    res2=@benchmark foo2(rand(n),1)
    res3=@benchmark foo3(rand(n),1)
    res4=@benchmark condat(rand(n),1)
    res5=@benchmark pcondat(rand(n),1)
    println("The length of vector is: ", n);
    write(io,"The length of vector is: $n\n");
    showcmp()
    showtime_memory()
    write(io, "=====================================================\n");
end
close(io);

#trial 2: standard norm distribution with a=1
rng=[10^5,5*10^5,10^6,5*10^6,10^7,5*10^7,10^8]
io = open("experiements_trail_2.txt", "a");
num=nthreads()
println("Trail 2 in standard norm distribution with ", num, " threads.")
write(io, "#####################################################\n");
write(io, "Trail 2 in standard norm distribution with $num threads.\n")
for i in rng
    global n, res1, res2, res3, res4, res5
    n=i
    Random.seed!(1234);
    res1=@benchmark foo1(rand(Normal(0,1),n),1)
    res2=@benchmark foo2(rand(Normal(0,1),n),1)
    res3=@benchmark foo3(rand(Normal(0,1),n),1)
    res4=@benchmark condat(rand(Normal(0,1),n),1)
    res5=@benchmark pcondat(rand(Normal(0,1),n),1)
    println("The length of vector is: ", n);
    write(io,"The length of vector is: $n\n");
    showcmp()
    showtime_memory()
    write(io, "=====================================================\n");
end
close(io);

#trial 3: norm distribution (std=0.001) with a=1
rng=[10^5,5*10^5,10^6,5*10^6,10^7,5*10^7,10^8]
io = open("experiements_trail_3.txt", "a");
num=nthreads()
println("Trail 3 in norm distribution (std=0.001) with ", num, " threads.")
write(io, "#####################################################\n");
write(io, "Trail 3 in norm distribution (std=0.001) with $num threads.\n")
for i in rng
    global n, res1, res2, res3, res4, res5
    n=i
    Random.seed!(1234);
    res1=@benchmark foo1(rand(Normal(0,0.001),n),1)
    res2=@benchmark foo2(rand(Normal(0,0.001),n),1)
    res3=@benchmark foo3(rand(Normal(0,0.001),n),1)
    res4=@benchmark condat(rand(Normal(0,0.001),n),1)
    res5=@benchmark pcondat(rand(Normal(0,0.001),n),1)
    println("The length of vector is: ", n);
    write(io,"The length of vector is: $n\n");
    showcmp()
    showtime_memory()
    write(io, "=====================================================\n");
end
close(io);

#trial 4: mixing data with a=1
rng=[10^5,5*10^5,10^6,5*10^6,10^7,5*10^7,10^8]
io = open("experiements_trail_4.txt", "a");
num=nthreads()
println("Trail 4 in mixing data with ", num, " threads.")
write(io, "#####################################################\n");
write(io, "Trail 4 in mixing data with $num threads.\n")
for i in rng
    global n, res1, res2, res3, res4, res5
    n=i
    Random.seed!(1234);
    res1=@benchmark foo1(shuffle(push!(rand(Normal(0,0.001),n-1),1)),1)
    res2=@benchmark foo2(shuffle(push!(rand(Normal(0,0.001),n-1),1)),1)
    res3=@benchmark foo3(shuffle(push!(rand(Normal(0,0.001),n-1),1)),1)
    res4=@benchmark condat(shuffle(push!(rand(Normal(0,0.001),n-1),1)),1)
    res5=@benchmark pcondat(shuffle(push!(rand(Normal(0,0.001),n-1),1)),1)
    println("The length of vector is: ", n);
    write(io,"The length of vector is: $n\n");
    showcmp()
    showtime_memory()
    write(io, "=====================================================\n");
end
close(io);
=#
#=
#trial 5: change the a from 1 to 1024
io = open("experiements_trail_5.txt", "a");
num=nthreads()
println("Trail 5 in different a with ", num, " threads.")
write(io, "#####################################################\n");
write(io, "Trail 5 in different a with $num threads.\n")
for i in 1:11
    global a, n, res1, res2, res3, res4, res5
    n=10_000_000
    a=2^(i-1)
    Random.seed!(1234);
    res1=@benchmark foo1(rand(Normal(0,1),n),a)
    res2=@benchmark foo2(rand(Normal(0,1),n),a)
    res3=@benchmark foo3(rand(Normal(0,1),n),a)
    res4=@benchmark condat(rand(Normal(0,1),n),a)
    res5=@benchmark pcondat(rand(Normal(0,1),n),a)
    println("The a = ", a);
    write(io,"The a = $a\n");
    showcmp()
    showtime_memory()
    write(io, "=====================================================\n");
end
close(io);
=#

#trial 6: change the a from 1 to 1024
io = open("experiements_trail_6.txt", "a");
num=nthreads()
println("Trail 6 in different a with ", num, " threads.")
write(io, "#####################################################\n");
write(io, "Trail 6 in different a with $num threads.\n")
for i in 1:11
    global a, n, res1, res2, res3, res4, res5
    n=100_000_000
    a=2^(i-1)
    Random.seed!(1234);
    res1=@benchmark foo1(rand(Normal(0,0.001),n),a)
    res2=@benchmark foo2(rand(Normal(0,0.001),n),a)
    res3=@benchmark foo3(rand(Normal(0,0.001),n),a)
    res4=@benchmark condat(rand(Normal(0,0.001),n),a)
    res5=@benchmark pcondat(rand(Normal(0,0.001),n),a)
    println("The a = ", a);
    write(io,"The a = $a\n");
    showcmp()
    showtime_memory()
    write(io, "=====================================================\n");
end
close(io);
