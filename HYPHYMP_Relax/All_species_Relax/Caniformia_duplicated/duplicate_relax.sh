##duplicated and  functional species files
sed -i '/^>/s/$/2/' Caniformia_COA1_duplicated.aln.faa
cat Caniformia.aln.faa Caniformia_COA1_duplicated.aln.faa|sed 's/-//g' > Caniformia_all.fa

grep ">" Caniformia_all.fa |grep -v "2" |sed 's/>//g' > functional.txt
grep ">" Caniformia_all.fa |grep "2" |sed 's/>//g' > pseudogene.txt

for i in `cat functional.txt` ; do grep -A1 "\b$i\b" Caniformia_all.fa >> functional.fa; done
for i in `cat pseudogene.txt` ; do grep -A1 "\b$i\b" Caniformia_all.fa >> pseudogene.fa; done 
guidance=/home/ceglab5/guidance.v2.02/www/Guidance/guidance.pl

for i in `cat pseudogene.txt`
do
j=`echo $i|sed 's/2//g'`
tree=Caniformia.nwk
grep -A1 "\b$i\b" pseudogene.fa > $i.seq
sed -e "/$j/,+1d" functional.fa > functional.faa
cat functional.faa  >> $i.seq
sed "s/$j/$j\{fg}/g" $tree > $i.nwk
done 

for i in *2.seq; do echo $i;sed -i 's/2//g' $i; done

for i in `cat pseudogene.txt`
do
perl $guidance --program GUIDANCE --seqFile "$i".seq --msaProgram PRANK --seqType codon --outDir "$i".100_PRANK --genCode 1 --bootstraps 100 --proc_num 16
cp "$i".100_PRANK/MSA.PRANK.aln.With_Names $i.2.seq 
done


rename 's/2.2.seq/.aln/g' *
rm *2.seq
rm -r *PRANK
rename 's/2.nwk/.nwk/g' *

##making config file for HYPHYMP
sed 's/2//g' pseudogene.txt >pseudo.list

for i in  `cat  pseudo.list`
do
seq="$i".aln
tree="$i".nwk
echo -ne  "1\n7\n1\n"$PWD"/$seq\n"$PWD"/"$tree"\n2\n2" > "$i"_tree.config
done


#Running hyphymp using config file 

for i in *config
do
HYPHYMP  <  $i > $i.out
done

##all output background foreground species with p and k value
for j in `ls -1 *out`
do
pval=`grep "^Like" $j|awk '{print $6}'|sed 's/\*\*\.//g'`
kval1=`grep "Relaxation/intensification" $j|awk '{print $6}'|head -1`
test=`grep "_test_ set:" $j|awk '{print $9}'|sed 's/\`//g'`
back=`grep "_reference_ set:" $j|cut -f2 -d ":"|sed 's/ //g'`
echo $test $back $pval $kval1 >>caniformia_duplicated_results.txt
done

