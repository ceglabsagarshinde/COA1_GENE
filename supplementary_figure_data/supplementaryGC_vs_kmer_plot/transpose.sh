file=$1
ncol=`awk '{ print NF }' $file|sort -u|sort -nr|head -1`
for col in `seq 1 1 $ncol`
do
awk '{print $c}' c=$col $file|tr '\n' '\t'|awk '{print}'
done
