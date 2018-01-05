
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


    shuffle_trials=1

    for _ in 1:shuffle_trials
        for i in 1:n
       
            v=intersect(points(1,i),points(2,i))
        
            hash_v=1+length(v)
            
            information+=log(n*hash_v/(u_h*v_h))
            
        end

    end

    information/(n*shuffle_trials)

end
        

        


