
for i in *.aln
do
t=`grep ">" $i|wc -l`
grep ">" $i|sed 's/>//g' > taxlist.txt
tree=`ls *nwk`
for j in `cat taxlist.txt`
do sed "s/$j/$j{fg}/g" $tree > "$j"_treeLabled.txt
echo -ne  "1\n7\n1\n"$PWD"/$i\n"$PWD"/"$j"_treeLabled.txt\n2\n2" > "$j"_tree.config
HYPHYMP<"$j"_tree.config > "$j"_treeoutput_relax
done
done

for j in `ls -1 *_relax`
do
pval=`grep "^Like" $j|awk '{print $6}'|sed 's/\*\*\.//g'`
kval1=`grep "Relaxation/intensification" $j|awk '{print $6}'|head -1`
test=`grep "_test_ set:" $j|awk '{print $9}'|sed 's/\`//g'`
back=`grep "_reference_ set:" $j|cut -f2 -d ":"|sed 's/ //g'`
echo $test $back $pval $kval1 >>caniform_functional_results.txt
done

