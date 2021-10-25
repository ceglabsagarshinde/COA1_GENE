#PAML version 4.9f
## The 5 phylogenetic tree taken from  https://github.com/robinvanderlee/positive-selection
# the file names are :
# 1.codeml_M0_tree__unrooted_tree__F3X4.tre
# 2.codeml_M0_tree__unrooted_tree__F61.tre
# 3.Ensembl78__9primates__with_taxon_id__unrooted.tre
# 4.Perelman_et_al__9primates__unrooted.tre
# 5.RAxML_bestTree__9primates__unrooted.tre




#making these two below files to tell the program which argument to select for nucleotide frequency model and codon models
echo -e "2\tF3x4" > cffile
echo -e "3\tF61" >> cffile
echo -e "M1vsM2\t1 2" > nssitesdetails
echo -e "M7vsM8\t7 8" >> nssitesdetails
##Running codeML using all 6 different trees
for tree in *.tre
do
file=MSA.PRANK.aln.With_Names
for cm in `echo F3x4 F61`
do
for models in `echo M1vsM2 M7vsM8`
do
cfreq=`grep "$cm" cffile|cut -f1`
cp demo.ctl "$file"_"$cm"_"$models"."$tree".ctl
sed -i "s/ssssss/$file/g" "$file"_"$cm"_"$models"."$tree".ctl
sed -i "s/tttttt/$tree/g" "$file"_"$cm"_"$models"."$tree".ctl
sed -i "s/CF/$cfreq/g" "$file"_"$cm"_"$models"."$tree".ctl
sed -i "s/oooooo/$file.$cm.$models.$tree.out/g" "$file"_"$cm"_"$models"."$tree".ctl
ns=`grep "$models" nssitesdetails|cut -f2`
sed -i "s/nnnnnn/$ns/g" "$file"_"$cm"_"$models"."$tree".ctl
#codeml "$file"_"$cm"_"$models"."$tree".ctl
done
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
head -n $k $outfile |tail -n $o |awk '{print $1"\t"$2"\t"$3}' |sed 's/*//g' |awk '$3>0.95{print of,"NEB",mdl,codmod,$1,$2,$3}' of=$outfile mdl=$model codmod=$cm OFS='\t' >> a.outresults_together.txt
fi
if [ $o1 -gt 1 ]
then
head -n $k1 $outfile |tail -n $o1 |awk '{print $1"\t"$2"\t"$3}' |sed 's/*//g' |awk '$3>0.95{print of,"BEB",mdl,codmod,$1,$2,$3}' of=$outfile mdl=$model codmod=$cm OFS='\t' >> a.outresults_together.txt
fi
done
