for outfile in `ls -1 *.out`
do
model=`echo $outfile|cut -f6 -d "."`
name=`echo $i|sed 's/.*codeml_//g'`
cm=`echo $outfile|cut -f5 -d "."`
j=`grep -n "BEB" $outfile |cut -f1 -d ':'` 
k=`expr $j - 3`
m=`grep -n "NEB" $outfile |cut -f1 -d ':'`
n=`expr $m + 5`
o=`expr $k - $n`
#echo $model $cm 
#echo -e "NEB\t$model\t$cm" >> outresults_together.txt
head -n $k $outfile |tail -n $o|sed '/^$/d' |awk '{print var3"\tNEB\t"var1"\t"var2"\t"$1"\t"$2"\t"$3}' var1=$model var2=$cm var3=$name|sed 's/*//g' |awk '$7>0.95{print $0}' >> outresults_together.txt
#echo -e "BEB\t$model\t$cm" >> outresults_together.txt
j=`grep -n "^The grid" $outfile |cut -f1 -d ':'` 
k=`expr $j - 3`
m=`grep -n "BEB" $outfile |cut -f1 -d ':'`
n=`expr $m + 5`
o=`expr $k - $n`
#echo $model $cm
head -n $k $outfile |tail -n $o|sed '/^$/d' |awk '{print var3"\tBEB\t"var1"\t"var2"\t"$1"\t"$2"\t"$3}' var1=$model var2=$cm var3=$name|sed 's/*//g' |awk '$7>0.95{print $0}' >> outresults_together.txt
done
