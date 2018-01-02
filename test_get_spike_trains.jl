include("./get_spike_trains.jl")
include("./metric.jl")

v_t=-55*mv::Float64
v_r=-70*mv::Float64
e_l=-70*mv::Float64

tau_m=12*ms::Float64
tau_ref=3*ms::Float64


average=14*mv::Float64
sigma=5*mv::Float64

lasts=30*ms::Float64

mu=0.2

dt=1*ms::Float64

spike_trains=get_spike_trains([v_t,v_r,e_l,tau_m,tau_ref],[average,sigma,lasts],mu,dt,5*sec)

println(spike_trains[1])
println(spike_trains[2])
