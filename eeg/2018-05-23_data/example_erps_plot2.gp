
set size 0.6,0.6
set xrange [0:0.501]
set xtics (0,0.1,0.2,0.3,0.4,0.5)
set xlabel "time (ms)"
set ylabel "field strength"
unset key

plot "example_erps_event_sigma2.dat" us 1:2 w lines  lt 1 lc rgb "black"
replot "example_erps_event_sigma2.dat" us 1:3 w lines  lt 1 lc rgb "black"
replot "example_erps_event_sigma2.dat" us 1:4 w lines  lt 1 lc rgb "black"
replot "example_erps_event_sigma2.dat" us 1:5 w lines  lt 1 lc rgb "black"
replot "example_erps_event_sigma2.dat" us 1:6 w lines  lt 1 lc rgb "black"