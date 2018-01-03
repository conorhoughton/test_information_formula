
function information_from_matrix(u_distances::Array{Float64,2},v_distances::Array{Float64,2},u_h::Int64,v_h::Int64)

    n=size(u_distances)[1]

    if n!= size(u_distances)[2] || n!=size(v_distances)[1] || n!=size(v_distances)[2]
        println("distance matrix size f/p")
    end

    information=0

    for i in 1:n

        u_points=[x[1] for x in sort!(shuffle([[i,d] for (i,d) in enumerate(u_distances[i,:])]),by = x -> x[2])[1:u_h]]
        v_points=[x[1] for x in sort!(shuffle([[i,d] for (i,d) in enumerate(v_distances[i,:])]),by = x -> x[2])[1:v_h]]

        information+=log(n*length(intersect(u_points,v_points))/(u_h*v_h))

    end

    information/n

end
        

        
        
