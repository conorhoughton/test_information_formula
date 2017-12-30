include("./metric.jl")
include("./neuron.jl")
include("./variable_input.jl")

v_t=-55*mv::Float64
v_r=-70*mv::Float64
e_l=-70*mv::Float64

tau_m=12*ms::Float64
tau_ref=3*ms::Float64


average=12*mv::Float64
sigma=5*mv::Float64

lasts=30*ms::Float64

neuron1=Neuron(v_t,v_r,e_l,tau_m,tau_ref)
neuron2=Neuron(v_t,v_r,e_l,tau_m,tau_ref)

variable_input=Variable_Input(average,sigma,lasts)
variable_input1=Variable_Input(average,sigma,lasts)
variable_input2=Variable_Input(average,sigma,lasts)

mu=0.2

t=0*sec::Float64

dt=1*ms::Float64

t_final=1*sec::Float64

while t<=t_final
    this_input=get_input!(variable_input,dt)
    this_input1=mu*get_input!(variable_input1,dt)+(1-mu)*this_input
    this_input2=mu*get_input!(variable_input2,dt)+(1-mu)*this_input
    update_neuron!(neuron1,this_input1,dt)
    update_neuron!(neuron2,this_input2,dt)
    println(t," ",neuron1.voltage," ",neuron2.voltage)
    t+=dt
end
