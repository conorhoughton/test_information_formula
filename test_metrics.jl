include("./spike_train_metrics.jl")
include("./metric.jl")

u_train=[0.1,0.3,0.5,0.7]
v_train=[0.11,0.3,0.6,0.7,0.8]
w_train=[0.09,0.1,0.11]
tau=12*ms

#println(traditional_metric(u_train,v_train,tau))
#println(traditional_metric(u_train,w_train,tau))
#println(traditional_metric(w_train,v_train,tau))

spike_trains=[u_train,v_train,w_train]

#println(spike_trains)

#println(typeof(spike_trains))

println(traditional_matrix(spike_trains,tau))

println(new_matrix(spike_trains,tau))

#println(new_metric(u_train,v_train,tau))
