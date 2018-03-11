


a_set=Set{Int64}(a for a in 1:100000)
b_set=Set{Int64}(a for a in 50000:150000)

@time length(intersect(a_set,b_set))

a_vector=Int64[a for  a in 1:100000]
b_vector=Int64[a for  a in 50000:150000]

@time length(intersect(a_vector,b_vector))
