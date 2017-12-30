
function information_from_dict(table::Dict{Array{Int64},Int64})

    function make_marginal(i::Int64)

        marginal=Dict{Int64,Int64}()

        for key in keys(table)
            marginal[key[i]]=get(table,key[i],0)+1
        end

        marginal
            
    end

    marginal1=make_marginal(1)
    marginal2=make_marginal(2)

    total=length(keys(table))

    information=0.0::Float64

    for key in keys
        p12=table[key]/total
        p1=marginal1/total
        p2=marginal2/total
        information+=p12*log(p12/(p1*p2))
    end
    
    information

end
