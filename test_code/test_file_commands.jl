

time=Dates.format(now(),"yyyy-mm-dd-HH-MM-SS")

println(time)
println(typeof(time))


run(`mkdir test/$time`)
run(`cp test_file_commands.jl test/$time/`)

file=open("test/$time/test.txt","w")

write(file,"hello world")

close(file)

println("write a message: ")
message=readline(STDIN)

file=open("test/messages.txt","a")

write(file,"$time $message\n")
