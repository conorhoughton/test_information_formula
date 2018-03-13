set size 0.6,0.6
set border 3
set xtics nomirror
set ytics nomirror
set xlabel "$h$"
set ylabel "mutual information"
plot "uncorr_av.dat" us 1:2 w lines lt rgb "black" title "information"
replot "uncorr_av.dat" us 1:3 w lines ls 2  title "correction"
