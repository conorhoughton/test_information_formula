include("./trains_to_word.jl")

spike_train1=Float64[0.1,0.2,0.3,0.7,0.9,1.0]
spike_train2=Float64[0.15,0.4,0.75,0.95,1.1]

table=trains_to_word(spike_train1,spike_train2,10,0.03).table

for key in keys(table)
    println(key," ",table[key])
end
