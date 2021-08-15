a=$1
c=`echo $a |cut -f1 -d "_"`
###making two files duplicate and functional seq of COA1
sed -i '/^>/s/$/2/' "$a".fa
cat "$c"_functional.fa "$a".fa|sed 's/-//g' > functional_duplicate.fa

grep ">" functional_duplicate.fa |grep -v "2" |sed 's/>//g' > functional.txt
grep ">" functional_duplicate.fa |grep "2" |sed 's/>//g' > duplicate.txt

for i in `cat functional.txt` ; do grep -A1 "\b$i\b" functional_duplicate.fa >> functional.fa; done
for i in `cat duplicate.txt` ; do grep -A1 "\b$i\b" functional_duplicate.fa >> duplicate.fa; done
guidance=/home/ceglab5/guidance.v2.02/www/Guidance/guidance.pl

for i in `cat duplicate.txt`
do
j=`echo $i|sed 's/2//g'`
tree=$a.nwk
grep -A1 "\b$i\b" duplicate.fa > $i.seq
sed -e "/$j/,+1d" functional.fa > functional.faa
cat functional.faa  >> $i.seq
sed "s/$j/$j\{fg}/g" $tree > $i.nwk
done


for i in *2.seq; do echo $i;sed -i 's/2//g' $i; done

for i in `cat duplicate.txt`
do
perl $guidance --program GUIDANCE --seqFile "$i".seq --msaProgram PRANK --seqType codon --outDir "$i".100_PRANK --genCode 1 --bootstraps 100 --proc_num 16
cp "$i".100_PRANK/MSA.PRANK.aln.With_Names $i.2.seq
done

sed -i 's/2//g' "$a".fa
rm functional.fa duplicate.fa
###remove some files
rename 's/2.2.seq/.aln/g' *
rm *2.seq
rm -r *PRANK
rename 's/2.nwk/.nwk/g' *
###making config file

sed  's/2//g' duplicate.txt >list.duplicate

for i in  `cat  list.duplicate`
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
for j in `ls -1 *out`
do
pval=`grep "^Like" $j|awk '{print $6}'|sed 's/\*\*\.//g'`
kval1=`grep "Relaxation/intensification" $j|awk '{print $6}'|head -1`
test=`grep "_test_ set:" $j|awk '{print $9}'|sed 's/\`//g'`
back=`grep "_reference_ set:" $j|cut -f2 -d ":"|sed 's/ //g'`
echo $test $back $pval $kval1 >> "$a".Results.txt
done

