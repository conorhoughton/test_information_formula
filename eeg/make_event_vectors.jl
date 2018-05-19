include("./make_simulated_env.jl")
include("./make_simulated_erp.jl")


function make_event_vectors(p::Float64)

    function get_rand()
        rand(-2:2)
    end

    coeff_name=Int64[get_rand() for i in 1:5]

    event_name=Int64[]

    for i in 1:5
        if rand()<=p
            r=get_rand()
            while r==coeff_name[i]
                r=get_rand()
            end
            push!(event_name,r)
        else
            push!(event_name,coeff_name[i])    
        end
    end

    (coeff_name,event_name)

end
         
function name_to_event(name::Tuple(Vector{Int64},Vector{Int64}))
    
    event_template=Float64[2.0,-3.0,3.0,2.0,5.0]

    ([convert(c,Float64) for c in name[1]],event_template+0.5*[convert(c,Float64) for c in name[2]])

end

function name_to_traces(name::Tuple(Vector{Int64},Vector{Int64}),length::Float64,timestep::Float64)

    events=name_to_event(name)

    env_vector=make_simulated_env(events[1],length,timestep)
    erp=make_simulated_erp(events[2])
    erp_vector=erp_as_vector(curve,length,timestep)
    
end

function traces_to_distance(traces::Tuple(Vector{Float64},Vector{Float64}))

    length(traces[1]-traces[2])

end


