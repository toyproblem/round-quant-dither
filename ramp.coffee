# Quantization error from ramp
fig2 = figure
    xlabel: "Samples"
    ylabel: "Quantization error"
    height: 180
    series:
        color: "green"
        shadowSize: 0
        lines: {lineWidth: 1, show:true}   
        points: {show: true}


# Quantization spectrum with/without dither
fig3 = figure
    xlabel: "Frequency bin"
    ylabel: "Quantization error PSD (dB)"
    yaxis: {min:-40, max:20}
    height: 200
    colors: ["green", "red"]
    series:
        shadowSize: 0
        lines: {lineWidth: 1, show:true}   
        points: {show: false}

N = 128 #; Number of samples
t = [1..N] #; Time (samples)
k = 21 #; Slope ($1 \leq$ integer $\leq N$)

# Quantization error
error = (s)-> # switch dither with s
        ramp = k/N*t
        dither = rand([N])-0.5
        ramp-round(ramp + dither*s)

# Plot quantization error without dither
plot t, error(0), fig: fig2

# Welch periodogram
periodogram = (u) -> abs(FFT(u)).pow(2)/N

# Quantization error PSD w/o dither
FFT = (u)-> complex(u,u*0).fft() # work-around
PSD0 = periodogram(error(0)) #;

# Quantization error PSD w/ dither
M = 64 #; Number of averages
PSD1 = (0 for [1..N]) #; Initialize
PSD1 += periodogram(error(1))/M for [1..M] #;

# Plot quantization PSDs
dB = (u) -> 10*log(u)/log(10)
plot t, [dB(PSD0), dB(PSD1)], fig:fig3
