
unset tics
unset key
unset border

plot "1" us 1:2 w lines lt -1 lw 10
replot "2" us 1:2 w lines lt -1 lw 10
replot "3" us 1:2 w lines lt -1 lw 10
replot "4" us 1:2 w lines lt -1 lw 10
replot "5" us 1:2 w lines lt -1 lw 10
replot "6" us 1:2 w lines lt -1 lw 10
replot "7" us 1:2 w lines lt -1 lw 10
replot "8" us 1:2 w lines lt -1 lw 10
replot "9" us 1:2 w lines lt -1 lw 10
replot "10" us 1:2 w lines lt -1 lw 10
replot "11" us 1:2 w lines lt -1 lw 10
replot "12" us 1:2 w lines lt -1 lw 10

set terminal gif size 6000,4800
set output "eeg.png"
replot
set terminal x11
replot