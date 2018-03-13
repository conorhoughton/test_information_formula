unset key
set size 0.6,0.6
set border 3
set xtics nomirror
set ytics nomirror
set xlabel "$h$"
set ylabel "mutual information"
plot "info_1.dat" us 1:2 w lines lt rgb "grey"
replot "info_2.dat" us 1:2 w lines lt rgb "grey"
replot "info_3.dat" us 1:2 w lines lt rgb "grey"
replot "info_4.dat" us 1:2 w lines lt rgb "grey"
replot "info_5.dat" us 1:2 w lines lt rgb "grey"
replot "info_6.dat" us 1:2 w lines lt rgb "grey"
replot "info_7.dat" us 1:2 w lines lt rgb "grey"
replot "info_8.dat" us 1:2 w lines lt rgb "grey"
replot "info_9.dat" us 1:2 w lines lt rgb "grey"
replot "info_10.dat" us 1:2 w lines lt rgb "grey"
replot "info_11.dat" us 1:2 w lines lt rgb "grey"
replot "info_12.dat" us 1:2 w lines lt rgb "grey"
replot "info_13.dat" us 1:2 w lines lt rgb "grey"
replot "info_14.dat" us 1:2 w lines lt rgb "grey"
replot "info_15.dat" us 1:2 w lines lt rgb "grey"
replot "info_16.dat" us 1:2 w lines lt rgb "grey"
replot "info_17.dat" us 1:2 w lines lt rgb "grey"
replot "info_18.dat" us 1:2 w lines lt rgb "grey"
replot "info_19.dat" us 1:2 w lines lt rgb "grey"
replot "info_20.dat" us 1:2 w lines lt rgb "grey"
replot "av.dat" us 1:2 w lines lt rgb "black" lw 2
