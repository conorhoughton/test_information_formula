include("./chop_train.jl")

struct Frequency_Table

    table::Dict{Array{Int64},Int64}

    function Frequency_Table()
        new(Dict{Array{Int64},Int64}())
    end

end

function trains_to_rate(spike_train1::Array{Float64},spike_train2::Array{Float64},window_length::Float64)

    function count(i::Int64)
        total=0
        while next[i]<=length(spike_train[i]) && spike_train[i][next[i]]<time
            total+=1
            next[i]+=1
        end
        total
    end

    table=Frequency_Table()

    next=[1,1]

    spike_train=Dict{Int64,Array{Float64}}(1=>spike_train1,2=>spike_train2)

    time=0


    while next[1]<=length(spike_train[1]) || next[2]<=length(spike_train[2])  
        time+=window_length
        total_array=[count(1),count(2)]
        
        table.table[total_array]=get(table.table,total_array,0)+1

    end

    table

end



function trains_to_rate(spike_train1::Array{Float64},spike_train2::Array{Float64},window_length::Float64,end_time::Float64)

    table=Frequency_Table()

    fragments1=chop_train(spike_train1,window_length,end_time)
    fragments2=chop_train(spike_train2,window_length,end_time)

    for i in 1:length(fragments1)
        total_array=[length(fragments1[i]),length(fragments2[i])]
        table.table[total_array]=get(table.table,total_array,0)+1
    end

    table

end


function trains_to_rate_shuffled(spike_train1::Array{Float64},spike_train2::Array{Float64},window_length::Float64,end_time::Float64)

    table=Frequency_Table()

    fragments1=chop_train(spike_train1,window_length,end_time)
    fragments2=shuffle!(chop_train(spike_train2,window_length,end_time))

    for i in 1:length(fragments1)
        total_array=[length(fragments1[i]),length(fragments2[i])]
        table.table[total_array]=get(table.table,total_array,0)+1
    end

    table

end



function shuffle_table(freq_table::Frequency_Table)

    table=freq_table.table

    second_key=shuffle([key[2] for key in keys(table)])

    new_table=Frequency_Table()

    for (i,key) in enumerate(keys(table))
        new_table.table[ [key[1],second_key[i]] ]=table[key]
    end

    new_table

end
        

function shuffle_train_for_rate(spike_train::Array{Float64},window_length::Float64)
    
    fragments=shuffle!(chop_train(spike_train,window_length,spike_train[end]))

    t=0

    new_train=Float64[]

    for (i,fragment) in enumerate(fragments)
        for time in fragment
            push!(new_train,time+(i-1)*window_length)
        end
    end

    new_train

end

function trains_get_rate(spike_train1::Array{Float64},spike_train2::Array{Float64},window_length::Float64)


    function count(i::Int64)
        total=0.0::Float64
        while next[i]<=length(spike_train[i]) && spike_train[i][next[i]]<time
            total+=1.0
            next[i]+=1
        end
        total
    end

    next=[1,1]

    rates1=Float64[]
    rates2=Float64[]

    spike_train=Dict{Int64,Array{Float64}}(1=>spike_train1,2=>spike_train2)

    time=0

    while next[1]<=length(spike_train[1]) || next[2]<=length(spike_train[2])  
        time+=window_length
        push!(rates1,count(1))
        push!(rates2,count(2))
        
    end

    (rates1,rates2)

end
    
