j=$1
tree="$j".nwk

for i in "$j".aln 
do
t=`grep ">" $i|wc -l`
grep ">" $i|sed 's/>//g' > taxlist.txt
for j in `cat taxlist.txt`
do sed "s/$j/$j{fg}/g" $tree > "$j"_treeLabled.txt
echo -ne  "1\n7\n1\n"$PWD"/$i\n"$PWD"/"$j"_treeLabled.txt\n2\n2" > "$j"_tree.config
HYPHYMP<"$j"_tree.config > "$j"_treeoutput_relax
done
done

###########################taking HYPHYMP output result in one file############################################################################################
for d in `ls -1 *_relax`
do
pval=`grep "^Like" $d|awk '{print $6}'|sed 's/\*\*\.//g'`
kval1=`grep "Relaxation/intensification" $d|awk '{print $6}'|head -1`
test=`grep "_test_ set:" $d|awk '{print $9}'|sed 's/\`//g'`
back=`grep "_reference_ set:" $d|cut -f2 -d ":"|sed 's/ //g'`
echo $test $back $pval $kval1 >>"$i".Results.txt
done

