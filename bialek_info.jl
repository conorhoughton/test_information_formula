include("./get_spike_trains.jl")
include("./trains_to_word.jl")
include("./information_from_dict.jl")
include("./get_spike_trains.jl")
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
mu=0.2

dt=0.1*ms::Float64

#for t in 1:50

word_length=30
letter_length=2*ms

for tl in 1:200

    train_length=50*sec*tl

    sigma_prime=sigma/sqrt(mu^2+(1-mu)^2)

    spike_trains=get_spike_trains([v_t,v_r,e_l,tau_m,tau_ref],[average,sigma_prime,lasts],mu,dt,train_length)


    frequency_table=trains_to_word(spike_trains[1],spike_trains[2],word_length,letter_length)

    println(information_from_dict(frequency_table.table)/(word_length*letter_length))

   
end
