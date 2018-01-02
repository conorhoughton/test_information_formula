
function traditional_metric(u_train::Array{Float64},v_train::Array{Float64},tau::Float64)

    println(trad_square_term(u_train,tau)," ",trad_square_term(v_train,tau))

    trad_square_term(u_train,tau)+trad_square_term(v_train,tau)-2*trad_cross_term(u_train,v_train,tau)

end

function trad_square_term(u_train::Array{Float64},tau::Float64)

    u_square=0

    for ui in u_train
        for uj in u_train
            u_square+=exp(-abs(ui-uj)/tau)
        end
    end

    u_square

end
    
function trad_cross_term(u_train::Array{Float64},v_train::Array{Float64},tau::Float64)

    cross=0

    for ui in u_train
        for vj in v_train
            cross+=exp(-abs(ui-vj)/tau)
        end
    end

    cross

end

struct Trad_Spike_Train
    train::Array{Float64}
    square_term::Float64
    
    function Trad_Spike_Train(train)
        new(train,trad_square_term(train,tau))
    end
end

function traditional_matrix(trains::Array{Array{Float64,1},1},tau::Float64)

    n=length(trains)

    
    spike_trains=[Trad_Spike_Train(train) for train in trains]

    matrix=zeros(n,n)

    for i in 1:n
        for j in i+1:n
            distance=spike_trains[i].square_term+spike_trains[j].square_term-2*trad_cross_term(spike_trains[i].train,spike_trains[j].train,tau)
            matrix[i,j]=distance
            matrix[j,i]=distance
        end
    end

    matrix

end


function markage(train::Array{Float64},tau)

    n=length(train)

    markage_vector=zeros(n)

    for i in 2:n
        markage_vector[i]=(markage_vector[i-1]+1)*exp(-(train[i]-train[i-1])/tau)
    end

    markage_vector

end

struct Spike_Train

    train::Array{Float64}
    markage_vector::Array{Float64}
    square_term::Float64
    length::Int64

    function Spike_Train(train,tau)
        markage_vector=markage(train,tau)
        new(train,markage_vector,2*sum(markage_vector)+length(train),length(train))
    end

end

function cross_term_uv(u_train::Spike_Train,v_train::Spike_Train,tau)

    big_j=1
    start_i=1

    while start_i<u_train.length && u_train.train[start_i]< v_train.train[big_j]
        start_i+=1
    end

    uv=0

    for i in start_i:u_train.length
        while big_j<v_train.length && v_train.train[big_j+1] <= u_train.train[i]
            big_j+=1
        end
        m=v_train.markage_vector[big_j]
        if u_train.train[i] != v_train.train[big_j]
            uv+=(1+m)*exp(-abs(u_train.train[i]-v_train.train[big_j])/tau)
        else
            uv+=(1/2+m)
        end
    end

    2*uv

end


function new_metric(u_train::Array{Float64},v_train::Array{Float64},tau::Float64)

    u_spike_train=Spike_Train(u_train,tau)
    v_spike_train=Spike_Train(v_train,tau)

    println(u_spike_train.square_term," ",v_spike_train.square_term)

    u_spike_train.square_term+v_spike_train.square_term-cross_term_uv(u_spike_train,v_spike_train,tau)-cross_term_uv(v_spike_train,u_spike_train,tau)

end





        


