##making config file for HYPHYMP
for i in `cat list.directory`
do
cd $i
seq="$i".aln
tree="$i".nwk
echo -ne  "1\n7\n1\n"$PWD"/$seq\n"$PWD"/"$tree"\n2\n2" > "$i"_tree.config
for j in *config 
do 
HYPHYMP  <  $j > $j.out

for j in `ls -1 *out`
do
pval=`grep "^Like" $j|awk '{print $6}'|sed 's/\*\*\.//g'`
kval1=`grep "Relaxation/intensification" $j|awk '{print $6}'|head -1`
test=`grep "_test_ set:" $j|awk '{print $9}'|sed 's/\`//g'`
back=`grep "_reference_ set:" $j|cut -f2 -d ":"|sed 's/ //g'`
echo $test $back $pval $kval1 > "$i".Results.txt
cd -
done
done
done

cd Node_results 
./relax.sh
cd ../
