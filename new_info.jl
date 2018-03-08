include("./get_spike_trains.jl")
include("./spike_train_metrics.jl")
include("./information_from_matrix.jl")
include("./metric.jl")
include("./chop_train.jl")
include("./neuron_parameters.jl")
include("./save.jl")

foldername=Foldername()
copy_source(foldername,"new_info.jl")
copy_source(foldername,"neuron_parameters.jl")

#mu=1.0 corresponds to independent

mu=0.3

#for t in 1:50

window_length=50*ms::Float64

big_h_stride=100
small_h_stride=8

h=76

tau=20*ms

trials_n=20

train_length=50*sec::Float64

run_parameter_names=["mu","window_length","h","big_h_stride","small_h_stride","tau","train_length","trials_n"]
run_parameters=Any[mu,window_length,"not in use","not in use","not in use",tau,"varies",trials_n]

save_to_log(foldername,vcat(neuron_parameters,run_parameters),vcat(neuron_parameter_names,run_parameter_names),"new")

small_file=open(string(foldername.name,"/info.dat"),"w")
big_file=open(string(foldername.name,"/all_data.dat"),"w")

key_file=open(string(foldername.name,"/README"),"w")

write(key_file,"info.dat:  mu average_info_over_trials\n")
write(key_file,"all_data.dat:  mu info_for_each_trial h_value_for_each_trial\n")

close(key_file)

#while train_length<=600*sec
#while window_length<=150*ms
#while mu<1.0

#    train_length=window_length/ms

    h=convert(Int64,floor(train_length/0.55))
    info_av=Float64[]
    h_av=Float64[]
    
    for trial_c in 1:trials_n
        
        spike_trains=get_spike_trains([v_t,v_r,e_l,tau_m,tau_ref],[input_max,lasts],mu,dt,train_length)
        
        fragments1=chop_train(spike_trains[1],window_length,train_length)
        fragments2=chop_train(spike_trains[2],window_length,train_length)
    
        distances1=new_matrix(fragments1,tau)
    
        distances2=new_matrix(fragments2,tau)
    
        h_best=h
        info_best=0
        infos=[]

        if trial_c==1
            stride=big_h_stride
        else
            stride=small_h_stride
        end

        for h_new in max(10,h-stride):10:h+stride
    
            info=information_from_matrix(distances1,distances2,h,h,1)/window_length
            corrected_info=info-background(length(fragments1),h_new)/window_length
            if corrected_info>info_best
                info_best=corrected_info
                h_best=h_new
            end
#            println(h_new," ",info_best)
        end

        h=h_best
    
        push!(h_av,h)
        push!(info_av,info_best)

    end
    
    av=mean(info_av)

    println(mu," ",window_length," ",train_length," ",av)

    write(small_file,"$mu $window_length $train_length $av\n")

    write(big_file,"$mu $window_length $train_length $info_av $h_av\n")

    flush(small_file)
    flush(big_file)

#    mu+=0.1

#    window_length+=10*ms

    train_length+=50*sec

end

close(small_file)
close(big_file)

comment_to_log()
