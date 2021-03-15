# performance a merge sort on vector v using parallel Threads
import Base: merge!
function psort(v::AbstractVector)
    hi=length(v)
    if hi<10_000 #this cutoff could be change to be better
        return sort(v, alg=QuickSort)
    end

    mid=(1+hi)>>>1
    half=Threads.@spawn psort(view(v,1:mid))
    right=psort(view(v,(mid+1):hi))
    left=fetch(half)::typeof(right)

    out=similar(v)
    pmerge!(out,left,right)
    return out
end


function merge!(out,left,right)
    ll, lr = length(left), length(right)
    @assert ll+lr == length(out)
    i, il, ir=1,1,1
    @inbounds while il <= ll && ir <= lr
        l, r= left[il], right[ir]
        if isless(r,l)
            out[i]=r
            ir +=1
        else
            out[i]=1
            il+=1
        end
        i+= 1
    end
    @inbounds while il <= ll
        out[i]=left[il]
        il+=1
        i += 1
    end
    @inbounds while ir <= lr
        out[i]=right[ir]
        ir+=1
        i += 1
    end
    return out
end

function pmerge!(out, left, right)
    ll, lr =length(left), length(right)
    @assert ll+lr == length(out)
    if length(out) < 10_000
        merge!(out,left,right)
    else
        if ll > lr
            jl=ll ÷ 2
            jr=searchsortedfirst(right,left[jl])-1
        else
            jr=lr ÷ 2
            jl=searchsortedlast(left,right[jr])
        end
        @sync begin
            let left=view(left,1:jl),
                right = view(right,1:jr),
                out=view(out,1:(jl+jr))
                Threads.@spawn pmerge!(out, left, right)
            end
            let left=view(left,(jl+1):ll),
                right = view(right,(jr+1):lr),
                out=view(out,(jl+jr+1):length(out))
                pmerge!(out, left, right)
            end
        end
    end
    nothing
end
