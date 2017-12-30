include("./metric.jl")
include("./neuron.jl")

v_t=-55*mv::Float64
v_r=-70*mv::Float64
e_l=-70*mv::Float64

tau_m=12*ms::Float64
tau_ref=3*ms::Float64


neuron=Neuron(v_t,v_r,e_l,tau_m,tau_ref)


t=0.0::Float64
input=18*mv::Float64
dt=1*ms::Float64

t_final=1.0::Float64

while t<=t_final
    update_neuron!(neuron,input,dt)
    println(t," ",neuron.voltage)
    t+=dt
end
