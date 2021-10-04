## This script will run codeml and compile the results of the gene loss timing estimation in Galliformes with different combinations of background and foreground. The All_Birds_multiple_label folder is excluded from the compilation of results. Please refer to the script Tp_estimation_multiple_label_birds.sh in that folder.
## The input file for running this script are present in the input_files folder in every species folder respectively.
## This script requires  ape and reshape2 package in R.

echo -e "Combination\tForeground\tBackgrounds\tmodel\tTm\twf\twm\tTf\tTp\tTf2\tTp2" > outfilecompile
for dir in `ls -d */|sed 's/\///g'|grep -v "multiple"`
do
cd $dir
rm codeml.ctl
echo $dir
j=`ls *ctl|wc -l`
if [ $j -lt 1 ]
then
for dir2 in `ls -d */|sed 's/\///g'`
do
cd $dir2
echo $dir2
rm codeml.ctl
tree=`ls -1 *nwk`
echo 'library(ape)' > splittime.r
echo 'library(reshape2)' >> splittime.r
echo 'a<-read.tree("'$tree'")' >> splittime.r
echo 'cophenetic(a)->v' >> splittime.r
echo 'subset(melt(v), value!=0)->v1' >> splittime.r
echo 'v1$value= round(v1$value/2,digit=2)' >> splittime.r
echo 'write.table(v1,file="pairwise.txt",quote=F,sep="\t",row.names=F,col.names=F)' >> splittime.r
chmod a+x splittime.r
Rscript splittime.r
sed -e 's/(/\n/g' -e 's/)/\n/g' -e 's/:/\n/g' -e 's/,/\n/g' $tree |grep "^[A-Z]" |grep "#" |sed -e 's/#.*//g'  -e 's/ //g' > fg.txt 
sed -e 's/(/\n/g' -e 's/)/\n/g' -e 's/:/\n/g' -e 's/,/\n/g' $tree |grep "^[A-Z]" |grep -v "#"  > bg.txt 
rm split_time.txt
for fg in `cat fg.txt`
do
for bg in `cat bg.txt`
do
grep "$fg" pairwise.txt |grep "$bg" >> fg.pairwise.txt
done
split=`cut -f3 fg.pairwise.txt |sort -n|head -n1`
echo -e "$fg\t$split" >> split_time.txt
rm fg.pairwise.txt
done
for ctl in `ls *ctl`
do
codeml "$ctl"
outfile=`grep "outfile =" $ctl|awk '{print $3}'`
for sp in `cat fg.txt`
do
bg=`cat bg.txt|tr '\n' ','|sed 's/,$/\n/g'`
tm=`grep "$sp" split_time.txt|awk '{print $2}'`
mdl=`grep "Codon frequency model:" $outfile|awk -F ":" '{print $2}'|awk '{print $1}'`
wf=`grep "w (dN/dS) for branches:" $outfile|awk '{print $5}'`
wm=`grep "w (dN/dS) for branches:" $outfile|awk '{print $6}'`
wp=`grep "w (dN/dS) for branches:" $outfile|awk '{print $7}'`
tf=`echo $tm $wm $wf | awk '{print $1*(($2 - 1)/($3 - 1))}'`
tp=`echo $tm $tf|awk '{print $1 - $2}'`
tf2=`echo $tm $tf $tp|awk '{print ($1*$2)/($2+(0.7*$3))}'`
tp2=`echo $tm $tf2|awk '{print $1-$2}'`
echo -e "$dir\t$sp\t$bg\t$mdl\t$tm\t$wf\t$wm\t$tf\t$tp\t$tf2\t$tp2" >> ../../outfilecompile
done
done
cd ..
done
else
rm codeml.ctl
for ctl in `ls *ctl`
do
rm codeml.ctl
codeml "$ctl"
tree=`ls -1 *nwk`
echo 'library(ape)' > splittime.r
echo 'library(reshape2)' >> splittime.r
echo 'a<-read.tree("'$tree'")' >> splittime.r
echo 'cophenetic(a)->v' >> splittime.r
echo 'subset(melt(v), value!=0)->v1' >> splittime.r
echo 'v1$value= round(v1$value/2,digit=2)' >> splittime.r
echo 'write.table(v1,file="pairwise.txt",quote=F,sep="\t",row.names=F,col.names=F)' >> splittime.r
chmod a+x splittime.r
Rscript splittime.r
sed -e 's/(/\n/g' -e 's/)/\n/g' -e 's/:/\n/g' -e 's/,/\n/g' $tree |grep "^[A-Z]" |grep "#" |sed -e 's/#.*//g'  -e 's/ //g' > fg.txt 
sed -e 's/(/\n/g' -e 's/)/\n/g' -e 's/:/\n/g' -e 's/,/\n/g' $tree |grep "^[A-Z]" |grep -v "#"  > bg.txt 
rm split_time.txt
for fg in `cat fg.txt`
do
for bg in `cat bg.txt`
do
grep "$fg" pairwise.txt |grep "$bg" >> fg.pairwise.txt
done
split=`cut -f3 fg.pairwise.txt |sort -n|head -n1`
echo -e "$fg\t$split" >> split_time.txt
rm fg.pairwise.txt
done
outfile=`grep "outfile =" $ctl|awk '{print $3}'`
for sp in `cat fg.txt`
do
bg=`cat bg.txt|tr '\n' ','|sed 's/,$/\n/g'`
tm=`grep "$sp" split_time.txt|awk '{print $2}'`
mdl=`grep "Codon frequency model:" $outfile|awk -F ":" '{print $2}'|awk '{print $1}'`
wf=`grep "w (dN/dS) for branches:" $outfile|awk '{print $5}'`
wm=`grep "w (dN/dS) for branches:" $outfile|awk '{print $6}'`
wp=`grep "w (dN/dS) for branches:" $outfile|awk '{print $7}'`
tf=`echo $tm $wm $wf | awk '{print $1*(($2 - 1)/($3 - 1))}'`
tp=`echo $tm $tf|awk '{print $1 - $2}'`
tf2=`echo $tm $tf $tp|awk '{print ($1*$2)/($2+(0.7*$3))}'`
tp2=`echo $tm $tf2|awk '{print $1-$2}'`
echo -e "$dir\t$sp\t$bg\t$mdl\t$tm\t$wf\t$wm\t$tf\t$tp\t$tf2\t$tp2" >> ../outfilecompile
done
done
fi
cd ..
done


#for dir in mammals_multiple_labels Rodents_multiple_labels
#do
#cd $dir
#chmod 777 Tp_estimation_multiple_label.sh
#bash Tp_estimation_multiple_label.sh
#cd ..
#done
chmod 777 multiple_label
bash multiple_label
