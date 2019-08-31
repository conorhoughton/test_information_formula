
include("./make_simulated_erp.jl")

ms=0.001

event_var=0.2::Float64
sigma_noise=5*ms
    
function noise()
    event_var*randn()
end

events=Float64[2.0+noise(),-3.5+noise(),3.0+noise(),2.0+noise(),2.5+noise()]

curve=make_simulated_erp(events,sigma_noise)

sigma=2.0
lambd=3.0

plot_erp(curve,1.0,1.55,0.001,sigma,lambd)
