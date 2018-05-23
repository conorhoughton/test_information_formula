
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

function make_events(stim_n::Int64)

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
    end

    events

end

function make_erps(events::Vector{Vector{Int64}},event_sigma::Float64,sigma::Float64,lambd::Float64,trial_n::Int64)

    erps=Erp[]
    for stim_c in 1:length(events)
        for trial_c in 1:trial_n
            trace=erp_as_vector(make_simulated_erp(name_to_event(make_erp_vector_normal(events[stim_c],event_sigma))),t_length,timestep,sigma,lambd)
            push!(erps,Erp(trace,stim_c))
        end
    end

    erps

end


trial_n=5


t_length=0.5
timestep=0.001
sigma=1.0
lambd=10.0
event_sigma=0.0

srand(0)
events=make_events(1)

erps=make_erps(events,event_sigma,sigma,lambd,trial_n)

for i in 1:length(erps[1].trace)
    print(timestep*(i-1)," ")
    for j in 1:trial_n
        print(erps[j].trace[i]," ")
    end
    print("\n")
end
        
