
for i in `cat list.nwk` 
do
seq=node.aln
tree="$i"
echo -ne  "1\n7\n1\n"$PWD"/$seq\n"$PWD"/"$tree"\n2\n2" > "$i"_tree.config
done

##Run the HYPHYMP using config file 
for j in *config; do HYPHYMP  <  $j > $j.out; done


##make single output file 
for j in `ls -1 *out`
do
pval=`grep "^Like" $j|awk '{print $6}'|sed 's/\*\*\.//g'`
kval1=`grep "Relaxation/intensification" $j|awk '{print $6}'|head -1`
test=`grep "_test_ set:" $j|awk '{print $9}'|sed 's/\`//g'`
back=`grep "_reference_ set:" $j|cut -f2 -d ":"|sed 's/ //g'`
echo $test $back $pval $kval1 >>Galiforms_node_Results.txt
done

