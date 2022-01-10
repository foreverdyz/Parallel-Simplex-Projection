#sortscan_pp.jl
using Base.Threads
using ThreadsX
function serial_sortscan_pp(data::AbstractVector)::AbstractVector
    let
        f=Array{AbstractFloat}(undef, length(data))
        for i in 1:length(data); f[i] = data[i] < 0 ? 0 : 1; end
        if sum(f)%2 == 0
            i = findmin(abs.(data))[2]
            f[i] = 1 - f[i]
        end
        v=Array{AbstractFloat}(undef, length(data))
        d=Array{AbstractFloat}(undef, length(data))
        for i in 1:length(data)
            v[i] = data[i]*(-1)^(f[i])
            d[i] = max(min(v[i], 0.5), -0.5)
        end
        if sum(d) >= (1-length(data)/2)
            for i in 1:length(data); d[i] = max(min(data[i], 0.5), -0.5); end
            return d
        else
            x=sortscan_s(v,1)
            for i in 1:length(data); x[i]=(x[i]-0.5)*(-1)^(f[i]); end
            return x
        end
    end
end

function parallel_sortscan_pp(data::AbstractVector)::AbstractVector
    let
        f=Array{AbstractFloat}(undef, length(data))
        @threads for i in 1:length(data); @inbounds f[i] = data[i] < 0 ? 0 : 1; end
        if sum(f)%2 == 0
            i = findmin(abs.(data))[2]
            f[i] = 1 - f[i]
        end
        v=Array{AbstractFloat}(undef, length(data))
        d=Array{AbstractFloat}(undef, length(data))
        @threads for i in 1:length(data)
            @inbounds v[i] = data[i]*(-1)^(f[i])
            @inbounds d[i] = max(min(v[i], 0.5), -0.5)
        end
        if ThreadsX.sum(d)>=(1-length(data)/2)
            @threads for i in 1:length(data); @inbounds d[i] = max(min(data[i], 0.5), -0.5); end
            return d
        else
            x=sortscan_p(v,1)
            @threads for i in 1:length(data); @inbounds x[i]=(x[i]-0.5)*(-1)^(f[i]); end
            return x
        end
    end
end

function parallel_sortPscan_pp(data::AbstractVector)::AbstractVector
    let
        f=Array{AbstractFloat}(undef, length(data))
        @threads for i in 1:length(data); @inbounds f[i] = data[i] < 0 ? 0 : 1; end
        if sum(f)%2 == 0
            i = findmin(abs.(data))[2]
            f[i] = 1-f[i]
        end
        v=Array{AbstractFloat}(undef, length(data))
        d=Array{AbstractFloat}(undef, length(data))
        @threads for i in 1:length(data)
            @inbounds v[i] = data[i]*(-1)^(f[i])
            @inbounds d[i] = max(min(v[i], 0.5), -0.5)
        end
        if ThreadsX.sum(d)>=(1-length(data)/2)
            @threads for i in 1:length(data); @inbounds d[i] = max(min(data[i], 0.5), -0.5); end
            return d
        else
            x=sortPscan_p(v,1)
            @threads for i in 1:length(data); @inbounds x[i]=(x[i]-0.5)*(-1)^(f[i]); end
            return x
        end
    end
end
