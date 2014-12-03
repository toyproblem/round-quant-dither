sum = nm.sum
dither = (u) -> rand(u) - 0.5

$blab.series =
        shadowSize: 0
        color: "green"
        lines: {lineWidth: 1, show:true}   
        points: {show: true}

N = 2.pow(6);
I = [1..N]
z=(7.6 + dither() for i in I)

sum(z)/N

plot I, z,
    xlabel: "x"
    ylabel: "w(x)"
    height: 160
    series: $blab.series



phase = (u, k)-> 
        v = (1+k/N)*u
        v-round(v+dither([N])*1)



1.2*I-round(I*1.2+dither([N]))

p = phase(I, 20)
            
P = abs(complex(p, p*0).fft())            




plot I, p,
    xlabel: "x"
    ylabel: "w(x)"
    height: 160
    series: $blab.series


plot I, 10*log(P)/log(10),
    xlabel: "x"
    ylabel: "w(x)"
    height: 160
    series: $blab.series

