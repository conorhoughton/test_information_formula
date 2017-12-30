include("./train_to_word.jl")

spike_train=Float64[0.1,0.2,0.3,0.7,0.9,1.0]

println(train_to_word(spike_train,10,0.03).table)
