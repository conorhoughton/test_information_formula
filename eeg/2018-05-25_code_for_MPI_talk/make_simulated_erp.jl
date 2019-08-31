
#include("../metric.jl")

using Dierckx

ms=0.001::Float64

function make_simulated_erp(events::Vector{Float64},sigma_time)


    
    function noise()
        sigma_time*randn()
    end

    
    pushfirst!(events,0.0)
    push!(events,0.0)
    events=-events

    ts= Float64[0*ms,50*ms+noise(), 100*ms+noise(), 180*ms+noise(), 220*ms+noise(), 400*ms+noise(),750*ms]

    
#    println(polyfit(events,ts))

    Spline1D(ts,events)

end

function plot_erp(curve,offset::Float64,time_length::Float64,timestep::Float64,sigma::Float64,lambd::Float64)

    vector_erp=erp_as_vector(curve,offset,time_length,timestep,sigma,lambd)
    
    for time_c in 1:length(vector_erp)
        println((time_c-1)*timestep," ",vector_erp[time_c])
    end

end


function erp_as_vector(curve,offset::Float64,length::Float64,timestep::Float64,sigma::Float64,lambd::Float64)
    
    function noise()
        sigma*randn()
    end

    t=0.0::Float64

    y=0.0
    while t<offset+length
        y+=-lambd*y*timestep+noise()*sqrt(timestep)
        t+=timestep
    end

    t=0.0
    
    

    vector_erp=Float64[]

    while t<offset
       push!(vector_erp,y)
        y+=-lambd*y*timestep+noise()*sqrt(timestep)
        t+=timestep
    end 

    t=0.0
    
    while t<length
        push!(vector_erp,curve(t)+y)
        y+=-lambd*y*timestep+noise()*sqrt(timestep)
        t+=timestep
    end

    vector_erp

end
