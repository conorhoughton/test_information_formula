#!/cm/shared/languages/Julia-0.6.2/julia-0.6.2/bin/julia

include("/panfs/panasas01/cosc/cscjh/test_information_formula/new_info_header_bc.jl")

foldername=Foldername()

#mu=1.0 corresponds to independent

mu=0.3

window_length=30*ms::Float64

tau=20*ms

trials_n=20

train_length=100*sec::Float64

run_parameter_names=["mu","window_length","h","tau","train_length","trials_n"]
run_parameters=Any[mu,window_length,"varies 10 to 100",tau,train_length,trials_n]

save_to_log(foldername,vcat(neuron_parameters,run_parameters),vcat(neuron_parameter_names,run_parameter_names),"new h run")

small_file=open(string(foldername.name,"/info.dat"),"w")

key_file=open(string(foldername.name,"/README"),"w")

write(key_file,"run for varying h\n")
write(key_file,"trial_c h uncorrect_info background corrected_info\n")
write(key_file,vcat(neuron_parameters,run_parameters))
write(key_file,vcat(neuron_parameter_names,run_parameter_names))
close(key_file)

#@profile begin

biggest_h=1000

for trial_c in 1:trials_n

        spike_trains=get_spike_trains([v_t,v_r,e_l,tau_m,tau_ref],[input_max,lasts],mu,dt,train_length)
        
        fragments=chop_train(spike_trains[1],window_length,train_length)

        points_1=get_and_sort_distances(fragments,tau,biggest_h)

        fragments=chop_train(spike_trains[2],window_length,train_length)

    	points_2=get_and_sort_distances(fragments,tau,biggest_h)

	fragments=length(fragments)

	spike_train=0


        function correct_info(h_new)
    
            info=information_from_matrix(points_1,points_2,h_new,h_new,1)/window_length
            this_background=background(fragments,h_new)/window_length
            (info,this_background,info-this_background)

        end

	h=10::Int64
	while h<=biggest_h
        
           (uncorr,backgr,corr)=correct_info(h)

           write(small_file,"$trial_c $h $uncorr $backgr $corr\n")

           flush(small_file)

           h+=1
   
       end

end

close(small_file)

#end

#Profile.print()

