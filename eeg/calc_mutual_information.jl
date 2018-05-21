
include("./make_event_vectors.jl")
include("./make_simulated_erp.jl")

struct Erp

    trace::Vector{Float64}
    trial::Int64

end


struct Distance

    d::Float64
    trial::Int64

end


function event_to_hash(event::Vector{Int64})

    base=1
    hash=0::Int64
    for i in 1:length(event)
        hash+=(2+event[i])*base
        base*=5
    end
    
    hash

end

trial_n=10
stim_n =10

t_length=0.5
timestep=0.001
sigma=1.5
lambd=10.0

p=0.1

erps=Erp[]

event_hashes=Int64[]

for stim_c in 1:stim_n
    event=make_event_vector()
    this_hash=event_to_hash(event)
    while this_hash in event_hashes
        event=make_event_vector()
        this_hash=event_to_hash(event)
    end
    push!(event_hashes,this_hash)

    for trial_c in 1:trial_n
        trace=erp_as_vector(make_simulated_erp(name_to_event(make_erp_vector(event,p))),t_length,timestep,sigma,lambd)
        push!(erps,Erp(trace,stim_c))
    end
end

distances=[Distance[] for _ in 1:length(erps)]

for i in 1:length(erps)
    for j in 1:length(erps)
        d=0.0::Float64
        if i!=j
            d=length(erps[i].trace-erps[j].trace)
        end
        push!(distances[i],Distance(d,erps[j].trial))
    end
end
        
    

