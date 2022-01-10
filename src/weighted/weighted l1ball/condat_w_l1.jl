using Base.Threads

function condat_w_l1(data,w,a)
    let
        z=abs.(data)
        if sum(z) <= a
            return data
        end
        y=wcondat_s(z,w,a)
        l=length(y)
        for i in 1:l
            if y[i]<0
                y[i]=-y[i]
            end
        end
        return y
    end
end

function pcondat_w_l1(data,w,a)
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
        y=wcondat_p(data,w,a)
        l=length(y)
        @threads for i in 1:l
            if data[i]<0
                y[i]=-y[i]
            end
        end
        return y
    end
end
