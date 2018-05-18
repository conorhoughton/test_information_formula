
include("./make_simulated_erp.jl")

events=Float64[2.0,-3.0,3.0,2.0,5.0]

curve=make_simulated_erp(events)

plot_poly(curve,0.5,0.001)
