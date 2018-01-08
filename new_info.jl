include("./get_spike_trains.jl")
include("./spike_train_metrics.jl")
include("./information_from_matrix.jl")
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
mu=0.2

dt=0.1*ms::Float64



#for t in 1:50

window_length=30*ms::Float64
h=100
h_stride=20

tau=2*ms

trials_n=15

while tau<=30

    info_av=0

    for _ in 1:trials_n

        train_length=30*sec::Float64

        #h=h0*convert(Int64,floor(train_length/(100*sec)))

        sigma_prime=sigma/sqrt(mu^2+(1-mu)^2)
        
        spike_trains=get_spike_trains([v_t,v_r,e_l,tau_m,tau_ref],[average,sigma_prime,lasts],mu,dt,train_length)
        
        fragments1=chop_train(spike_trains[1],window_length,train_length)
        fragments2=chop_train(spike_trains[2],window_length,train_length)
        
        distances1=new_matrix(fragments1,tau)
        distances2=new_matrix(fragments2,tau)
        
        
        h_best=h
        info_best=0
        
        for h_new in max(20,h-h_stride):2:h+h_stride
            info=information_from_matrix(distances1,distances2,h_new,h_new)/window_length
            corrected_info=info-background(length(fragments1),h_new)/window_length
            if corrected_info> info_best
                info_best=corrected_info
                h_best=h_new
            end
            
        end
        
        h=h_best
    
        info_av+=info_best
        
    end
    
    println(tau," ",mu," ",h," ",info_av/trials_n)

    tau+=2*ms
   
   
end
