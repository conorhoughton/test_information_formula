
include("../metric.jl")

using Dierckx

function make_simulated_erp(events::Vector{Float64})

    pushfirst!(events,0.0)
    push!(events,0.0)
    events=-events

    ts= Float64[0*ms,50*ms, 100*ms, 180*ms, 220*ms, 400*ms,550*ms]

#    println(polyfit(events,ts))

    Spline1D(ts,events)

end

function plot_erp(curve,time_length::Float64,timestep::Float64,sigma::Float64,lambd::Float64)

    vector_erp=erp_as_vector(curve,time_length,timestep,sigma,lambd)
    
    for time_c in 1:length(vector_erp)
        println((time_c-1)*timestep," ",vector_erp[time_c])
    end

end


function erp_as_vector(curve,length::Float64,timestep::Float64,sigma::Float64,lambd::Float64)
    
    function noise()
        sigma*randn()
    end

    t=0.0::Float64

    y=0.0

    vector_erp=Float64[]

    while t<length
        push!(vector_erp,curve(t)+y)
        y+=-lambd*y*timestep+noise()*sqrt(timestep)
        t+=timestep
    end

    vector_erp

end
