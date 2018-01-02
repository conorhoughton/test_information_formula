
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

    
