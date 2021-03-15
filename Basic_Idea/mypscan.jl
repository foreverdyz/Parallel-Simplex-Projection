#=This function will help us to find the τ from a sorted vector
with multiple threads.=#
using Base.Threads
#y is the soted data. a is the constant
function mypscan(data,a)
    l=length(data)
    k=ceil(Int,log2(l))
    s=copy(data)
    global p=14
    for j=1:k
        @threads for i =2^j:2^j:min(l,2^k)
            @inbounds s[i]=s[i-2^(j-1)]+s[i]
        end
        pivot=(s[min(l,2^j)]-a)/min(l,2^j)
        if pivot>=data[min(l,2^j)]
            global p=j
            break
        end
    end
    global st=2^(p-1)
    for j = (p-1):-1:1
        global st
        i=min(st+2^(j-1),l)
        s[i]=s[st]+s[i]
        pivot=(s[i]-a)/i
        if pivot<data[i]
            st=i
        elseif pivot==data[i] || i==l
            break
        end
    end

    return st
end
