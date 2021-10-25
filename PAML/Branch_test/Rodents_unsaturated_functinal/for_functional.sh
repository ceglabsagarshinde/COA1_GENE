## This folder contains branch-test files and results.
# The nwk file is the species tree downloaded from timetree.org and the name replaced by TimeTree in it have been modified.
# to remove internode labels from the TimeTree nwk file
for i in `ls *.nwk`
do
sed -e "s/'[^()]*'//g" $i > temp.nwk
mv temp.nwk $i
echo 'library(ape)' > tree_script.r
echo "a<-read.tree(\"$i\")" >> tree_script.r
echo 'b<-unroot(a)' >> tree_script.r
echo "write.tree(b,\"$i.tree\")" >> tree_script.r
Rscript tree_script.r
mv $i.tree $i
done

# This script check whether the species name in the fasta file and nwk file are same or not.
for i in `ls *.fa`
do
grep ">" $i|sed 's/>//g' > $i.txt
j=`ls *.nwk`
sed 's/(/\n/g' $j|sed 's/)/\n/g' |sed 's/;/\n/g' |sed 's/:/\n/g' |sed 's/,/\n/g' |grep "^[A-Z]" > $j.txt
echo $j
cat $i.txt $j.txt |sort|uniq -c |awk '$1<2 {print $2}'
rm *.txt
done


# made groupwise folder and do alignment
#guidance=/Path/to/guidance.pl
guidance=`locate guidance.pl|head -n1`
#guidance=/home/nagarjun/guidance.v2.02/www/Guidance/guidance.pl
for i in `ls *.fa`
do
j=`echo $i|sed 's/.fa//g'`
perl $guidance --program GUIDANCE --seqFile "$i" --msaProgram PRANK --seqType codon --outDir "$i".100_PRANK --genCode 1 --bootstraps 100 --proc_num 16
cp "$i".100_PRANK/MSA.PRANK.aln.With_Names "$j".aln
rm -r "$i".100_PRANK
done

## For making alingment file into two line fasta file
for i in `ls *.aln`
do
sed -e '/^>/s/$/@/' -e 's/^>/#/' $i | tr -d '\n' |sort| tr "#" "\n" | tr "@" "\t"| sed -e 's/^/>/'|sed '1d' -|sed 's/\t/\n/g' > $i.faa
done

## For taking one species as a foregorund and rest as background
echo -e "2\tF3x4" > cffile
echo -e "1\tF1x4" >> cffile
echo -e 'M0\t0\t0\t0.4\nbfree\t2\t0\t0.4\nbneutral\t2\t1\t1' > model_details

## labelling foreground species in tree and running branch model using PAML.
tree=`ls *.nwk`
align=`ls *.faa`
for i in `grep ">" *.aln.faa |sed 's/>//g'`
do
sed "s/$i/$i #1/g" "$tree" > "$i".nwk
for m in M0 bfree bneutral
do
for cf in F3x4 F1x4
do
CF=`grep "$cf" cffile|cut -f1`
x=`echo "$i"_"$cf"_"$m"`
cp demo.ctl "$x".ctl
sed -i "s/ssssss/$align/g" $x.ctl
sed -i "s/tttttt/$i.nwk/g" $x.ctl
sed -i "s/CF/$CF/g" $x.ctl
sed -i "s/oooooo/$x.out/g" $x.ctl
mdl=`grep "$m" model_details|awk '{print $2}'`
FO=`grep "$m" model_details|awk '{print $3}'`
OMG=`grep "$m" model_details|awk '{print $4}'`
sed -i "s/mdl/$mdl/g" $x.ctl
sed -i "s/FO/$FO/g" $x.ctl
sed -i "s/OMG/$OMG/g" $x.ctl
#codeml $x.ctl
done
done
done

