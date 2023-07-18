#simplex_robust_test.jl

using BenchmarkTools, Random, Distributions
BenchmarkTools.DEFAULT_PARAMETERS.gcsample = true
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100
BenchmarkTools.DEFAULT_PARAMETERS.seconds = 20

include("simplex and l1ball/simplex_wrap.jl")

println("You are using ", nthreads(), " threads for parallel computing")

Random.seed!(12345);
let
    num = 0
    for _ in 1:10
        local res = condat_s(rand(Normal(0,1), 10^7), 1)
        num += length(findnz(res)[1])
    end
    println(num)
end

function dense_pscan(data::Array{Float64, 1}, pivot::Real)::Array{Float64, 1}
    let
        d = zeros(length(data))
        @threads for i in 1:length(data)
            local x = data[i] - pivot
            (x > 0) && (d[i] = x)
        end
        return d
    end
end

function dense_sortscan_s(data::Array{Float64, 1}, b::Real)::AbstractVector
    pivot = sortscan_pivot(data, b)
    return max.(data.-pivot, 0)
end

function dense_sortscan_p(data::Array{Float64, 1}, b::Real, numthread::Int)::AbstractVector
    pivot = sortscan_parallel_pivot(data, b)
    return dense_pscan(data, pivot)
end

function dense_sortPscan_p(data::Array{Float64, 1}, b::Real, numthread::Int)::AbstractVector
    #using parallel mergesort here
    d_after_sort = sort(data; alg = ThreadsX.MergeSort, rev = true)
    #get the pivot
    pivot = parallel_partial_scan(d_after_sort, b)
    return dense_pscan(data, pivot)
end

function dense_michelot_s(data::Array{Float64, 1}, b::Real)::AbstractVector
    #here we need to make a copy of data, otherwise the algorithm will change data
    pivot = serial_scan(data[1:end], b)
    return max.(data.-pivot, 0)
end

function dense_michelot_p(data::Array{Float64, 1}, b::Real, numthread, spa::Float64)#::AbstractVector
    active_list = parallel_scan(data, b, numthread, spa)
    pivot = serial_scan(active_list, b)
    return max.(data.-pivot, 0)
    #return dense_pscan(data, pivot)
end

function dense_condat_s(data::Array{Float64, 1}, b::Real = 1)::AbstractVector
    active_list = serial_filter(data, b)
    pivot = checkL(active_list, b)
    return max.(data.-pivot, 0)
end

function dense_condat_p(data::Array{Float64, 1}, b::Real, numthread::Int, spa::Float64)::AbstractVector
    active_list = parallel_filter(data, b, numthread, spa)
    pivot = checkL(active_list, b)
    return max.(data.-pivot, 0)
end

function bigb_test_condat()
    for i in [0,2,4,6]
        b = 10^i
        println("b = ", b)
        Random.seed!(12345); res = @benchmark dense_condat_s($(rand(Normal(0, 1), 10^8)), $(b));
        println("serial dense: ", median(res))
        Random.seed!(12345); res = @benchmark condat_s($(rand(Normal(0, 1), 10^8)), $(b));
        println("serial sparse: ", median(res))
        Random.seed!(12345); res = @benchmark dense_condat_p($(rand(Normal(0, 1), 10^8)), $(b), nthreads(), 0.0001);
        println("parallel dense: ", median(res))
        Random.seed!(12345); res = @benchmark condat_p($(rand(Normal(0, 1), 10^8)), $(b), nthreads(), 0.001);
        println("parallel sparse: ", median(res))
    end
end

function bigb_test_michelot()
    for i in [0,2,4,6]
        b = 10^i
        println("b = ", b)
        #Random.seed!(12345); res =  @benchmark dense_michelot_s($(rand(Normal(0, 1), 10^8)), $(b));
        #println("serial dense: ", median(res))
        Random.seed!(12345); res = @benchmark michelot_s($(rand(Normal(0, 1), 10^8)), $(b));
        println("serial sparse: ", median(res))
        #Random.seed!(12345); res = @benchmark dense_michelot_p($(rand(Normal(0, 1), 10^8)), $(b), 40, 0.0);
        #println("parallel dense: ", median(res))
        Random.seed!(12345); res = @benchmark michelot_p($(rand(Normal(0, 1), 10^8)), $(b), 10, 0.0);
        println("parallel sparse: ", median(res))
    end
end

function bigb_test_sortscan()
    for i in [0,2,4,6]
        b = 10^i
        println("b = ", b)
        #Random.seed!(12345); res = @benchmark dense_sortscan_s($(rand(Normal(0, 1), 10^8)), $(b));
        #println("serial dense sortscan: ", median(res))
        Random.seed!(12345); res = @benchmark sortscan_s($(rand(Normal(0, 1), 10^8)), $(b));
        println("serial sparse sortscan: ", median(res))
        #Random.seed!(12345); res = @benchmark dense_sortscan_p($(rand(Normal(0, 1), 10^8)), $(b), 16);
        #println("parallel dense sortscan: ", median(res))
        #Random.seed!(12345); res = @benchmark dense_sortPscan_p($(rand(Normal(0, 1), 10^8)), $(b), 16);
        #println("parallel dense sortPscan: ", median(res))
        Random.seed!(12345); res = @benchmark sortscan_p($(rand(Normal(0, 1), 10^8)), $(b), 10);
        println("parallel sparse sortscan: ", median(res))
        Random.seed!(12345); res = @benchmark sortPscan_p($(rand(Normal(0, 1), 10^8)), $(b), 10);
        println("parallel sparse sortOscan: ", median(res))
    end
end
