include("./get_spike_trains.jl")
include("./trains_to_rate.jl")
include("./information_from_matrix.jl")
include("./spike_train_metrics.jl")
include("./metric.jl")

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

dt=1*ms::Float64

#for t in 1:50



while mu< 1

    train_length=200*sec

    sigma_prime=sigma/sqrt(mu^2+(1-mu)^2)

    spike_trains=get_spike_trains([v_t,v_r,e_l,tau_m,tau_ref],[average,sigma_prime,lasts],mu,dt,train_length)

    window_length=100*ms::Float64

    (rates1,rates2)=trains_get_rate(spike_trains[1],spike_trains[2],window_length)

    distances1=rate_distance_matrix(rates1)
    distances2=rate_distance_matrix(rates2)

    h=convert(Int64,floor(length(rates1)/2))

    println(mu," ",information_from_matrix(distances1,distances2,h,h)/window_length)

    mu+=0.1

end
