

include("./make_event_vectors.jl")


trials=10000::Int64
p=0.1::Float64

probs=Dict{Tuple{Vector{Int64},Vector{Int64}},Float64}

for trial_c in 1:trials

    event=make_event_vectors(p)

    probs[event]=get(probs,event,0.0)+1.0/trials

end

marginal1=Dict{Int64{Vector},Float64}
marginal2=Dict{Int64{Vector},Float64}

for key in keys(probs)
    marginal1[key[1]]=get(marginal1,key[1],0.0)+probs[key]
    marginal1[key[2]]=get(marginal1,key[2],0.0)+probs[key]
end

mutual_info=0.0::Float64


for key in keys(probs)
    mutual_info+=probs[key]*log(probs[key]/(marginal1[key[1]]*marginal2[key[2]]))
end

println(mutual_info)
