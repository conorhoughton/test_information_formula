
include("./make_simulated_erp.jl")

events=Float64[4.0,-3.0,5.0,-2.0,5.0]

curve=make_simulated_erp(events)

#plot_poly(curve,0.45,0.001)
