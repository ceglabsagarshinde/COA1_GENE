## branch-free 
##PAML version 4.9f
#USAGE: ./branch_free.sh filename treename
## Doing Branch free
## made our demo_branch_free.ctl file for running codeml branch-free as control file
# making species list for labelling tree
file=$1
tree=$2
grep ">" $file |sed 's/>//g' > species_list

echo -e "2\tF3x4" > cffile
echo -e "1\tF1x4" >> cffile
for cm in `echo F3x4 F1x4`
do
cfreq=`grep "$cm" cffile|cut -f1`
cp demo_branch_free.ctl "$file"_"$cm"_branch_free.ctl
sed -i "s/ssssss/$file/g" "$file"_"$cm"_branch_free.ctl
sed -i "s/tttttt/$tree/g" "$file"_"$cm"_branch_free.ctl
sed -i "s/CF/$cfreq/g" "$file"_"$cm"_branch_free.ctl
sed -i "s/oooooo/$file.$cm.out/g" "$file"_"$cm"_branch_free.ctl
codeml "$file"_"$cm"_branch_free.ctl
done

for i in Primates_MYH4 Primates_Rodents.MYH4; do k=`echo "$i".aln`; t=`echo "$i".nwk`; ./branch_free.sh $k $t; done

