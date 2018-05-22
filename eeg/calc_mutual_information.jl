
include("./make_event_vectors.jl")
include("./make_simulated_erp.jl")
include("./estimate_background.jl")

struct Erp

    trace::Vector{Float64}
    stim::Int64

end


struct Distance

    d::Float64
    stim::Int64

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

trial_n=100
stim_n =10

t_length=0.5
timestep=0.001
sigma=1.0
lambd=10.0

p=0.2

erps=Erp[]

event_hashes=Int64[]

events=[Int64[] for _ in 1:stim_n]

for stim_c in 1:stim_n
    event=make_event_vector()
    this_hash=event_to_hash(event)
    while this_hash in event_hashes
        event=make_event_vector()
        this_hash=event_to_hash(event)
    end
    push!(event_hashes,this_hash)
    events[stim_c]=event

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
            d=norm(erps[i].trace-erps[j].trace)
        end
        push!(distances[i],Distance(d,erps[j].stim))
    end
end
        
h=trial_n

sorted_distances=[Distance[] for _ in 1:length(erps)]

for i in 1:length(erps)
    sorted_distances[i]=sort(vcat(distances[i][1:i-1],distances[i][i+1:end]),by = x -> x.d)
end

max=0.0

for h in 1:2*trial_n
    information=0.0
    for i in 1:length(erps)
        b=1
        for j in 1:h-1
            if sorted_distances[i][j].stim==erps[i].stim
                b+=1
            end
        end
        
        information+=log2(stim_n*b/h)

    end

    this_info=information/length(erps)-estimate_background(h,trial_n,stim_n)

    if this_info>max
        max=this_info
    end

end

println(max," ",numerical_ground_truth(events,p,10000)-numerical_ground_truth_bgd(events,p,10000))
