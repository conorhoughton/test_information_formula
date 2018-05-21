

function estimate_background(h::Int64,trial_n::Int64,stim_n::Int64)


    function binomial_coeff(p::Float64,n::Int64,k::Int64)
        coeff=(1-p)^(n-k)
        for i in 1:k
            coeff*=(n+1-i)/i*p
        end

         coeff

    end


    p=1.0/stim_n

    information=0.0

    for r in 0:h-1

        
        prob=binomial_coeff(p,h-1,r)

        information+=prob*log2(stim_n*(r+1)/h)

    end

    information

end

#this is incorrect!
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


    
