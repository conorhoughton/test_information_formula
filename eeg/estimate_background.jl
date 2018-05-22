

function estimate_background(h::Int64,trial_n::Int64,stim_n::Int64)


    function binomial_coeff(p::Float64,n::Int64,k::Int64)

        coeff=(1-p)^(n-k)
        for i in 1:k
            coeff*=(n+1-i)/i*p
        end

         coeff

    end


    p=(trial_n-1)/(stim_n*trial_n-1)

    information=0.0

    for r in 0:h-1

        prob=binomial_coeff(p,h-1,r)

        information+=prob*log2(stim_n*(r+1)/h)

    end

    information

end

function numerical_ground_truth(events::Vector{Vector{Int64}},p::Float64,test_n::Int64)
    
    event_pairs=Vector{Tuple{Vector{Int64},Vector{Int64}}}()
    
    for event in events
        for trial_c in 1:test_n
            push!(event_pairs,(event,make_erp_vector(event,p)))
        end
    end

    probs=Dict{Tuple{Vector{Int64},Vector{Int64}},Float64}()

    sample_n=length(event_pairs)

    for pair in event_pairs
        probs[pair]=get(probs,pair,0.0)+1.0/sample_n
    end
 

    marginal1=Dict{Vector{Int64},Float64}()
    marginal2=Dict{Vector{Int64},Float64}()


    for key in keys(probs)
        marginal1[key[1]]=get(marginal1,key[1],0.0)+probs[key]
        marginal2[key[2]]=get(marginal2,key[2],0.0)+probs[key]
    end

    mutual_info=0.0::Float64

    for key in keys(probs)
        mutual_info+=probs[key]*log2( probs[key] / ( marginal1[key[1]]*marginal2[key[2]] ) )
    end

    mutual_info

end


function numerical_ground_truth_bgd(events::Vector{Vector{Int64}},p::Float64,test_n::Int64)
    
    event_pairs=Vector{Tuple{Vector{Int64},Vector{Int64}}}()

    events_scrambled=shuffle(events)


    for trial_c in 1:test_n
        events_scrambled=shuffle(events)
        for i in 1:length(events)
            push!(event_pairs,(events_scrambled[i],make_erp_vector(events[i],p)))
        end
    end

    probs=Dict{Tuple{Vector{Int64},Vector{Int64}},Float64}()

    sample_n=length(event_pairs)

    for pair in event_pairs
        probs[pair]=get(probs,pair,0.0)+1.0/sample_n
    end
 

    marginal1=Dict{Vector{Int64},Float64}()
    marginal2=Dict{Vector{Int64},Float64}()


    for key in keys(probs)
        marginal1[key[1]]=get(marginal1,key[1],0.0)+probs[key]
        marginal2[key[2]]=get(marginal2,key[2],0.0)+probs[key]
    end

    mutual_info=0.0::Float64

    for key in keys(probs)
        mutual_info+=probs[key]*log2( probs[key] / ( marginal1[key[1]]*marginal2[key[2]] ) )
    end

    mutual_info

end
    


#this function is incorrect!
function estimated_ground_truth(stim_n::Int64,p::Float64)

    n=5
    v=5

    hx=log2(stim_n)

    hy_given_x=0.0::Float64

    for odds in 0:n
        
        number=(v-1)^odds

        prob=p^odds *(1-p)^(n-odds)  * 1.0/number

        if prob>0
            hy_given_x-= binomial(n,odds)*number*prob*log2(prob)
        end

    end

    #i need hy-hy_given_x
    (stim_n-1)*hy_given_x

end


    
