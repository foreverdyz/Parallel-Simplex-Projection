using Base.Threads
using ThreadsX
using. wsimplex

function sortscan_w_l1(data,w,a)
    let
        z=abs.(data)
        if sum(z) <= a
            return data
        end
        y=wsortscan_s(z,w,a)
        l=length(y)
        for i in 1:l
            if data[i]<0
                y[i]=-y[i]
            end
        end
        return y
    end
end

function psortscan_w_l1(data,w,a)
    let
        z=zeros(length(data))
        @threads for i in 1:length(data)
            if data[i]<0
                z[i] = -data[i]
            end
        end
        if ThreadsX.sum(z) <= a
            return data
        end
        y=wsortscan_p(z,w,a)
        l=length(y)
        @threads for i in 1:l
            if data[i]<0
                y[i]=-y[i]
            end
        end
        return y
    end
end
