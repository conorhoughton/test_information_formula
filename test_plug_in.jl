include("./get_spike_trains.jl")
include("./spike_train_metrics.jl")
include("./information_from_matrix.jl")
include("./metric.jl")
include("./chop_train.jl")
include("./neuron_parameters.jl")
include("./save.jl")

foldername=Foldername()
copy_source(foldername,"test_plug_in.jl")


#mu=1.0 corresponds to independent

mu=0.2


#for t in 1:50

window_length=50*ms::Float64


tau=20*ms

trials_n=1

train_length=100*sec::Float64

run_parameter_names=["mu","window_length","h","tau","train_length","trials_n"]
run_parameters=Any[mu,window_length,"varies",tau,train_length,trials_n]

save_to_log(foldername,vcat(neuron_parameters,run_parameters),vcat(neuron_parameter_names,run_parameter_names),"test plug in")

small_file=open(string(foldername.name,"/info.dat"),"w")


key_file=open(string(foldername.name,"/README"),"w")

write(key_file,"a test programme for looking at the plug in formula for calculating bandwidth\n")


close(key_file)


spike_trains=get_spike_trains([v_t,v_r,e_l,tau_m,tau_ref],[input_max,lasts],mu,dt,train_length)
        
fragments1=chop_train(spike_trains[1],window_length,train_length)
fragments2=chop_train(spike_trains[2],window_length,train_length)
        
distances1=new_matrix(fragments1,tau)
distances2=new_matrix(fragments2,tau)
                

for h in 10:2:150
    big_j=j_from_matrix(distances1,distances2,h)
    println(h," ",big_j)
        
    write(small_file,h," ",big_j)
end

close(small_file)


comment_to_log()
