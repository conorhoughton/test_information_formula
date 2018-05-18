
function make_simulated_env(coeffs::Vector{Float64},length::Float64,timestep::Float64)

    function wave(t::Float64)
        w=0
        for i in 8:12
           w+=coeffs[i-7]*sin(i*t*2*pi)
        end
        w
    end

    
    t=0.0::Float64

    vector_env=Float64[]

    while t<length
        push!(vector_env,wave(t))
        t+=timestep
    end

    vector_env

end

function plot_env(vector_env::Vector{Float64},timestep::Float64)

    
    t=0.0::Float64

    for v in vector_env
        println(t," ",v)
        t+=timestep
    end

end
