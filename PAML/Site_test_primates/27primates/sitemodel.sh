#guidance=/home/nagarjun/guidance.v2.02/www/Guidance/guidance.pl #change this according to your path
#seqfile=$1 #change this according to your file name
##we have already kept demo.ctl in the folder
#perl $guidance --program GUIDANCE --seqFile "$seqfile" --msaProgram PRANK --seqType codon --outDir "$seqfile".100_PRANK --genCode 1 --bootstraps 100 --proc_num 4

#cp "$seqfile".100_PRANK/MSA.PRANK.aln.With_Names .

###the below two files we need to give relevant input to the control file for CodeML
echo $PWD
echo -e "2\tF3x4" > cffile
echo -e "3\tF61" >> cffile
echo -e "M1vsM2\t1 2" > nssitesdetails
echo -e "M7vsM8\t7 8" >> nssitesdetails

file=primates_27list.aln
tree=primates_27list.nwk # the tree is species tree downloaded from timetree.org
for i in "$tree"
do
echo 'library(ape)' > tree_script.r
echo "a<-read.tree(\"$i\")" >> tree_script.r
echo 'b<-unroot(a)' >> tree_script.r
echo 'b$node.label<-NULL' >> tree_script.r
echo "write.tree(b,\"$i.tree\")" >> tree_script.r
Rscript tree_script.r
mv $i.tree $i
cat "$tree"
done

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
rm a.outresults_together.txt
rm 2NG.t 2NG.dS 2NG.dN

for ctl in `ls *ctl|grep -v "demo.ctl\|codeml.ctl"`
do
tree=`grep "treefile =" $ctl|awk '{print $3}'`
outfile=`grep "outfile =" $ctl|awk '{print $3}'`
model=`grep "^NSsites =" $ctl|awk '{print "M"$3,"M"$4}' OFS='vs'`
cminti=`grep "CodonFreq =" $ctl|awk '{print $3}'`
cm=`grep "^$cminti" cffile|cut -f2`
echo $outfile $tree
j=`grep -n "BEB" $outfile |cut -f1 -d ':'` 
k=`expr $j - 3`
m=`grep -n "NEB" $outfile |cut -f1 -d ':'`
n=`expr $m + 5`
o=`expr $k - $n`
j1=`grep -n "^The grid" $outfile |cut -f1 -d ':'` 
k1=`expr $j1 - 3`
m1=`grep -n "BEB" $outfile |cut -f1 -d ':'`
n1=`expr $m1 + 5`
o1=`expr $k1 - $n1`
if [ $o -gt 1 ]
then
#echo -e "NEB\t$model\t$cm\t$tree" >> $tree.outresults_together.txt
head -n $k $outfile |tail -n $o |awk '{print $1"\t"$2"\t"$3}' |sed 's/*//g' |awk '$3>0.95{print of,"NEB",mdl,codmod,$1,$2,$3}' of=$outfile mdl=$model codmod=$cm OFS='\t' >> a.outresults_together.txt
fi
#echo -e "BEB\t$model\t$cm\t$tree" >> $tree.outresults_together.txt
if [ $o1 -gt 1 ]
then
head -n $k1 $outfile |tail -n $o1 |awk '{print $1"\t"$2"\t"$3}' |sed 's/*//g' |awk '$3>0.95{print of,"BEB",mdl,codmod,$1,$2,$3}' of=$outfile mdl=$model codmod=$cm OFS='\t' >> a.outresults_together.txt
fi
done
