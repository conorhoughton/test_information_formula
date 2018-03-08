
include("./metric.jl")
include("./neuron.jl")
include("./uniform_variable_input.jl")
include("./neuron_parameters.jl")
include("./get_spike_trains.jl")


mu=0.::Float64

train_length=100000*sec

while mu<=1.0

    trains=get_spike_trains([v_t,v_r,e_l,tau_m,tau_ref],[input_max,lasts],mu,dt,train_length)
    spike_total=size(trains[1],1)+size(trains[2],1)
    println(mu," ",spike_total/train_length)
    mu+=0.1

end
