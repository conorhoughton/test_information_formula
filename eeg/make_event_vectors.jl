
function make_event_vectors(p::Float64)

    function get_rand()
        rand(-3:3)
    end


    coeff_name=Int64[get_rand() for i in 1:5]

    event_name=Int64[]
    for i in 1:5
        if rand()<p
            push!(event_name,coeff_name[i])
        else
            push!(event_name,get_rand())
    
        end
    end

    (coeff_name,event_name)

end
         
    
    
