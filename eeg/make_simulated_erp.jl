
include("./Polynomials.jl")
include("../metric.jl")

using Polynomials

function make_simulated_erp(events::Vector{Float64})

    ts= Float64[50*ms, 100*ms, 180*ms, 220*ms, 400*ms]

    events=[t^2 for t in ts]

    println(polyfit(events,ts))

    polyfit(events,ts)

end

function plot_poly(poly::Poly{Float64},length::Float64,timestep::Float64)
    
    t=0.0::Float64

    while t<length
        println(t," ",curve(t))
        t+=timestep
    end

end
