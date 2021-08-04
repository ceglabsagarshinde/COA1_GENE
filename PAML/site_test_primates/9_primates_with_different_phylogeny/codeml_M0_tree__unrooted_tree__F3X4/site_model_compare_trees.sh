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
codeml "$file"_"$cm"_"$models"."$tree".ctl
done
done
done
##compiling the results in one file
for outfile in `ls -1 *.out`
do
model=`echo $outfile|cut -f2 -d "_"|cut -f2 -d "."`
cm=`echo $outfile|cut -f2 -d "_"|cut -f3 -d "."`
tree=`echo $outfile|sed "s/.*$cm.//g"`
echo $outfile $tree
j=`grep -n "BEB" $outfile |cut -f1 -d ':'` 
k=`expr $j - 3`
m=`grep -n "NEB" $outfile |cut -f1 -d ':'`
n=`expr $m + 5`
o=`expr $k - $n`
echo -e "NEB\t$model\t$cm\t$tree" >> outresults_together.txt
head -n $k $outfile |tail -n $o |awk '{print $1"\t"$2"\t"$3}' |sed 's/*//g' |awk '$3>0.95{print $0}' >> outresults_together.txt
echo -e "BEB\t$model\t$cm\t$tree" >> outresults_together.txt
j=`grep -n "^The grid" $outfile |cut -f1 -d ':'` 
k=`expr $j - 3`
m=`grep -n "BEB" $outfile |cut -f1 -d ':'`
n=`expr $m + 5`
o=`expr $k - $n`
head -n $k $outfile |tail -n $o |awk '{print $1"\t"$2"\t"$3}' |sed 's/*//g' |awk '$3>0.95{print $0}' >> outresults_together.txt
done

