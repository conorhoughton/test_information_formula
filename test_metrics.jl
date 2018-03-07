include("./spike_train_metrics.jl")
include("./metric.jl")


u_train=[0.01581]
v_train=[0.0071]
w_train=[0.0158]

tau=20*ms

#println(traditional_metric(u_train,v_train,tau))
#println(traditional_metric(u_train,w_train,tau))
#println(traditional_metric(w_train,v_train,tau))

spike_trains=[u_train,v_train,w_train]

#println(spike_trains)

#println(typeof(spike_trains))

println(traditional_matrix(spike_trains,tau))

println(new_matrix(spike_trains,tau))

#println(new_metric(u_train,v_train,tau))
