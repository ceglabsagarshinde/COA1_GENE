guidance=/home/nagarjun/guidance.v2.02/www/Guidance/guidance.pl #change this according to your path
seqfile=$1 #change this according to your file name
##we have already kept demo.ctl in the folder
perl $guidance --program GUIDANCE --seqFile "$seqfile" --msaProgram PRANK --seqType codon --outDir "$seqfile".100_PRANK --genCode 1 --bootstraps 100 --proc_num 4

cp "$seqfile".100_PRANK/MSA.PRANK.aln.With_Names .

###the below two files we need to give relevant input to the control file for CodeML
echo -e "2\tF3x4" > cffile
echo -e "3\tF61" >> cffile
echo -e "M1vsM2\t1 2" > nssitesdetails
echo -e "M7vsM8\t7 8" >> nssitesdetails

file=MSA.PRANK.aln.With_Names
tree=primates_27list.nwk # the tree is species tree downloaded from timetree.org
##running the programs with on above mentioned files with two different codon models and comparing two different site models
for cm in `echo F3x4 F61`
do
for models in `echo M1vsM2 M7vsM8`
do
cfreq=`grep "$cm" cffile|cut -f1`
cp demo.ctl "$file"_"$cm"_"$models".ctl
sed -i "s/ssssss/$file/g" "$file"_"$cm"_"$models".ctl
sed -i "s/tttttt/$tree/g" "$file"_"$cm"_"$models".ctl
sed -i "s/CF/$cfreq/g" "$file"_"$cm"_"$models".ctl
sed -i "s/oooooo/$file.$cm.$models.out/g" "$file"_"$cm"_"$models".ctl
ns=`grep "$models" nssitesdetails|cut -f2`
sed -i "s/nnnnnn/$ns/g" "$file"_"$cm"_"$models".ctl
codeml "$file"_"$cm"_"$models".ctl
done
done
##compiling the results in one file
for outfile in `ls -1 *.out`
do
model=`echo $outfile|cut -f6 -d "."`
cm=`echo $outfile|cut -f5 -d "."`
j=`grep -n "BEB" $outfile |cut -f1 -d ':'` 
k=`expr $j - 3`
m=`grep -n "NEB" $outfile |cut -f1 -d ':'`
n=`expr $m + 5`
o=`expr $k - $n`
echo -e "NEB\t$model\t$cm" >> outresults_together.txt
head -n $k $outfile |tail -n $o |awk '{print $1"\t"$2"\t"$3}' |sed 's/*//g' |awk '$3>0.95{print $0}' >> outresults_together.txt
echo -e "BEB\t$model\t$cm" >> outresults_together.txt
j=`grep -n "^The grid" $outfile |cut -f1 -d ':'` 
k=`expr $j - 3`
m=`grep -n "BEB" $outfile |cut -f1 -d ':'`
n=`expr $m + 5`
o=`expr $k - $n`
head -n $k $outfile |tail -n $o |awk '{print $1"\t"$2"\t"$3}' |sed 's/*//g' |awk '$3>0.95{print $0}' >> outresults_together.txt
done
