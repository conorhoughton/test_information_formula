include("./information_from_dict.jl")



table=Dict([0,0]=>8,[0,1]=>4,[1,1]=>2,[1,0]=>2)

#=

00 1/2
01 1/4
11 1/8
10 1/8

[p1,p2]

p1[0]=3/4
p1[1]=1/4

p2[0]=5/8
p2[1]=3/8


(below needs to be minused)

00   1/2 log  15/32 // 1/2 = 1/2 log 15/16
01   1/4 log  9/32 // 1/4  = 1/4 log 9/8
10   1/8 log  5/32 // 1/8  = 1/8 log 5/4
11   1/8 log  3/32 // 1/8  = 1/8 log 3/4


=#

by_hand=-( 0.5*log(15/16)+0.25*log(9/8)+0.125*log(5/4)+0.125*log(3/4))

println(by_hand)

println(information_from_dict(table)) 

