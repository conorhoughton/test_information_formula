

include("./make_event_vectors.jl")


function analytical_calculation(p::Float64,n::Int64,v::Int64)

    hx=v*log(n)/log(2.0)

    hy_given_x=0.0::Float64

   
    for odds in 0:n
        
        number=(v-1)^odds

        prob=p^odds *(1-p)^(n-odds)  * 1.0/number

        if prob>0
            hy_given_x-= binomial(n,odds)*number*prob*log(prob)/log(2.0)
        end

    end

    hx-hy_given_x

end


trials=100::Int64
p=0.0::Float64

while p<=1.01

    probs=Dict{Tuple{Vector{Int64},Vector{Int64}},Float64}()

    for trial_c in 1:trials

        event=make_event_vectors(p)
        probs[event]=get(probs,event,0.0)+1.0/trials

    end

    marginal1=Dict{Vector{Int64},Float64}()
    marginal2=Dict{Vector{Int64},Float64}()
    
    for key in keys(probs)
        marginal1[key[1]]=get(marginal1,key[1],0.0)+probs[key]
        marginal2[key[2]]=get(marginal2,key[2],0.0)+probs[key]
    end




    mutual_info=0.0::Float64

    for key in keys(probs)
        mutual_info+=probs[key]*log( probs[key] / ( marginal1[key[1]]*marginal2[key[2]] ) ) / log(2.0)
    end
    
    println(p," ",mutual_info," ",analytical_calculation(p,5,5))

    p+=0.025

end
