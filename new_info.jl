include("./get_spike_trains.jl")
include("./spike_train_metrics.jl")
include("./information_from_matrix.jl")
include("./get_spike_trains.jl")
include("./metric.jl")
include("./chop_train.jl")

v_t=-55*mv::Float64
v_r=-70*mv::Float64
e_l=-70*mv::Float64

tau_m=12*ms::Float64
tau_ref=5*ms::Float64


average=18*mv::Float64
sigma=8*mv::Float64

lasts=30*ms::Float64

#mu=1.0 corresponds to independent
mu=0.0

dt=0.1*ms::Float64

tau=12*ms

#for t in 1:50

window_length=100*ms::Float64
h0=100

while mu<=1

    train_length=200*sec::Float64

    h=h0*convert(Int64,floor(train_length/(100*sec)))

    sigma_prime=sigma/sqrt(mu^2+(1-mu)^2)

    spike_trains=get_spike_trains([v_t,v_r,e_l,tau_m,tau_ref],[average,sigma_prime,lasts],mu,dt,train_length)

    fragments1=chop_train(spike_trains[1],window_length,train_length)
    fragments2=chop_train(spike_trains[2],window_length,train_length)

    distances1=new_matrix(fragments1,tau)
    distances2=new_matrix(fragments2,tau)

    println(mu," ",information_from_matrix(distances1,distances2,h,h)/window_length)

    mu+=0.025

   
end
