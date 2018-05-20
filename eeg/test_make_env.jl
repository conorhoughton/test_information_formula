
include("./make_simulated_env.jl")

coeffs=Float64[2.0,-3.0,3.0,2.0,5.0]

dt=0.001

curve=make_simulated_env(coeffs,0.5,dt,1.0)

plot_env(curve,dt)
