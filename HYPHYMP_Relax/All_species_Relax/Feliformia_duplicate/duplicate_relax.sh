###making two files duplicate and functional seq of COA1
##duplicate COA1gene list Feliformia_COA1_duplicated.faa
##functional coa1 Feliformia.fa.PRANK.faa



sed -i '/^>/s/$/2/' Feliformia_COA1_duplicated.faa
cat Feliformia.fa.PRANK.faa Feliformia_COA1_duplicated.faa|sed 's/-//g' > Feliformia_all.fa

grep ">" Feliformia_all.fa |grep -v "2" |sed 's/>//g' > functional.txt
grep ">" Feliformia_all.fa |grep "2" |sed 's/>//g' > pseudogene.txt

for i in `cat functional.txt` ; do grep -A1 "\b$i\b" Feliformia_all.fa >> functional.fa; done
for i in `cat pseudogene.txt` ; do grep -A1 "\b$i\b" Feliformia_all.fa >> pseudogene.fa; done
guidance=/home/ceglab5/guidance.v2.02/www/Guidance/guidance.pl

##adding the forground label in tree file
for i in `cat pseudogene.txt`
do
j=`echo $i|sed 's/2//g'`
tree=Feliformia.nwk
grep -A1 "\b$i\b" pseudogene.fa > $i.seq
sed -e "/$j/,+1d" functional.fa > functional.faa
cat functional.faa  >> $i.seq
sed "s/$j/$j\{fg}/g" $tree > $i.nwk
done

##running the prank using Guidance with one duplicated and remaining functional sequences of COA1
for i in *2.seq; do echo $i;sed -i 's/2//g' $i; done

for i in `cat pseudogene.txt`
do
perl $guidance --program GUIDANCE --seqFile "$i".seq --msaProgram PRANK --seqType codon --outDir "$i".100_PRANK --genCode 1 --bootstraps 100 --proc_num 16
cp "$i".100_PRANK/MSA.PRANK.aln.With_Names $i.2.seq
done

######remove and change the file names

rename 's/2.2.seq/.aln/g' *
rm *2.seq
rm -r *PRANK
rename 's/2.nwk/.nwk/g' *

#making config file for relax test

sed  's/2//g' pseudogene.txt >list.psedo

for i in  `cat  list.psedo`
do
seq="$i".aln
tree="$i".nwk
echo -ne  "1\n7\n1\n"$PWD"/$seq\n"$PWD"/"$tree"\n2\n2" > "$i"_tree.config
done

#####running HYPHYMP
for i in *config
do
HYPHYMP  <  $i > $i.out
done

##########################################
##taking output in one file 
for j in `ls -1 *out`
do
pval=`grep "^Like" $j|awk '{print $6}'|sed 's/\*\*\.//g'`
kval1=`grep "Relaxation/intensification" $j|awk '{print $6}'|head -1`
test=`grep "_test_ set:" $j|awk '{print $9}'|sed 's/\`//g'`
back=`grep "_reference_ set:" $j|cut -f2 -d ":"|sed 's/ //g'`
echo $test $back $pval $kval1 >>Feliformia_duplicated_results.txt
done