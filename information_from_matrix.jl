
function information_from_matrix(u_distances::Array{Float64,2},v_distances::Array{Float64,2},u_h::Int64,v_h::Int64)

    n=size(u_distances)[1]

    if n!= size(u_distances)[2] || n!=size(v_distances)[1] || n!=size(v_distances)[2]
        println("distance matrix size f/p")
    end

    information=0

    function points(u::Int64,i::Int64)
        excised=vcat(distances[u][i,1:i-1],distances[u][i,i+1:end])
        [convert(Int64,x[1]) for x in sort!(shuffle([[i,d] for (i,d) in enumerate(excised)]),by = x -> x[2])[1:u_h]]
    end

    distances=(u_distances,v_distances)

    shuffle_n=1

    for _ in 1:shuffle_n
        for i in 1:n
        
            v=intersect(points(1,i),points(2,i))
            
            hash_v=1+length(v)
            
            information+=log(n*hash_v/(u_h*v_h))
        
        end
    end

    information/(n*shuffle_n)

end
        

function calculate_coefficient(n::Int64,h::Int64,r::Int64)

    value=1.0::Float64

    if r==0
        for counter in 0:h-1
            value*=(n-h-counter)/(n-counter)
         end
        return value
    end

    # (h r) (n-h h-r) / (n h)
    # (h ... r terms) (n-h  (h-r) terms)    (h . . . 1)
    # (r ... 1)     (h-r . . . 1)         (n ..  h terms)
    #

    for counter in 0:h-r-1
        value*= ((n-h-counter)/(n-counter)) * ((h-counter)/(h-r-counter)) 
    end

    for counter in 0:r-1
        value*= ((h-counter)/(n-h+r-counter))
    end

    value

end


function background(n::Int64,h::Int64)

    info=0.0::Float64

    for r in 0:h-1
        info+= calculate_coefficient(n-1,h-1,r)*log( n*(r+1)/(h^2))
    end
    
    info

end

