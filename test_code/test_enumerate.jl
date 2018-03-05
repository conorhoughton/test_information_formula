
u=["a","b","c"]

v=enumerate(u)

println(typeof(u)," ",typeof(v))

println(u)

println(v)

w=[[i,x] for (i,x) in v]

println(typeof(w))

println(w) 

println(typeof(w[1][1]))
println(typeof(w[1][2]))
