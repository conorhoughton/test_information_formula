
include("./metric.jl")
include("./variable_input.jl")

average=10*mv::Float64
sigma=5*mv::Float64

lasts=30*ms::Float64

input=Variable_Input(average,sigma,lasts)


t=0*sec::Float64
dt=1*ms::Float64

t_final=0.2*sec::Float64

while t<=t_final
    rate=get_input!(input,dt)
    println(t," ",rate)
    t+=dt
end
