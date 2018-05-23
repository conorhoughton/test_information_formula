set size 0.6,0.6
unset key
set xlabel "trials per stimulus"
set ylabel "mutual information (bits)"
plot "info_v_trial_n.dat" us 1:3 w lines