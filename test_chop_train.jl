
include("./chop_train.jl")

train=Float64[0.1,0.25,0.3,0.3, 0.31,0.5,0.642,0.712]

println(chop_train(train,0.2,1.0))

