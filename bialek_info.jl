include("./get_spike_trains.jl")
include("./trains_to_word.jl")
include("./information_from_dict.jl")
include("./get_spike_trains.jl")
include("./metric.jl")
include("./neuron_parameters.jl")
include("./save.jl")


foldername=Foldername()
copy_source(foldername,"bialek_info.jl")
copy_source(foldername,"neuron_parameters.jl")


#mu=1.0 corresponds to independent
mu=0.0
word_length=25
letter_length=2*ms

train_length=50*sec::Float64

trials_n=5

mu=0.2

run_parameter_names=["mu","word_length","letter_length","train_length","trials_n"]
run_parameters=Any[mu,word_length,letter_length,"varies",trials_n]

save_to_log(foldername,vcat(neuron_parameters,run_parameters),vcat(neuron_parameter_names,run_parameter_names),"bialek")

small_file=open(string(foldername.name,"/info.dat"),"w")
big_file=open(string(foldername.name,"/all_data.dat"),"w")

key_file=open(string(foldername.name,"/README"),"w")

write(key_file,"info.dat:  mu average_info_over_trials\n")
write(key_file,"all_data.dat:  mu info_for_each_trial\n")


while train_length<100*sec

#    sigma_prime=sigma/sqrt(mu^2+(1-mu)^2)
    
    info_av=Float64[]
    h_av=Float64[]

    for _ in 1:trials_n

        spike_trains=get_spike_trains([v_t,v_r,e_l,tau_m,tau_ref],[input_max,lasts],mu,dt,train_length)

        println(length(spike_trains[1])/train_length," ",length(spike_trains[2])/train_length)

        frequency_table=trains_to_word(spike_trains[1],spike_trains[2],word_length,letter_length,train_length)
        info=information_from_dict(frequency_table.table)/(word_length*letter_length)

        frequency_table_shuffled=trains_to_word_shuffled(spike_trains[1],spike_trains[2],word_length,letter_length,train_length)
        info_shuffled=information_from_dict(frequency_table_shuffled.table)/(word_length*letter_length)

        push!(info_av,info-info_shuffled)

#        println(info-info_shuffled," ",info," ",info_shuffled)

    end

    
    av=mean(info_av)

    println(train_length," ",av)

    write(small_file,"$train_length $av\n")

    write(big_file,"$train_length $info_av\n")


    flush(small_file)
    flush(big_file)

    train_length+=5000*sec
   
end

close(small_file)
close(big_file)

comment_to_log()
