for i in $(seq 1 20)
do
#echo $i
grep "^$i " < info.dat | awk '{print $2" "0.03*($5)}'> info_$i.dat
done