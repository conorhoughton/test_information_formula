
include("../metric.jl")

using Dierckx

function make_simulated_erp(events::Vector{Float64})

    unshift!(events,0.0)
    push!(events,0.0)
    events=-events

    ts= Float64[0*ms,50*ms, 100*ms, 180*ms, 220*ms, 400*ms,550*ms]

#    println(polyfit(events,ts))

    Spline1D(ts,events)

end

function plot_erp(curve,length::Float64,timestep::Float64)
    
    t=0.0::Float64

    while t<length
        println(t," ",curve(t))
        t+=timestep
    end

end


function erp_as_vector(curve,length::Float64,timestep::Float64)
    
    t=0.0::Float64

    vector_erp=Float64[]

    while t<length
        push!(vector_erp,curve(t))
        t+=timestep
    end

    vector_erp

end
