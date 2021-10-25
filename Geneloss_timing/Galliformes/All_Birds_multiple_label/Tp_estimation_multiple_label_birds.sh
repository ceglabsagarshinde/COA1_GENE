## This script is specifically for Birds multiple label folder for Tp estimation where we get multiple omega values in return in our out file.
## For cannonical outfile of Tp estimation, please refer to wrapper_script.sh
for ctl in *.ctl
do
codeml "$ctl"
dir=`echo $PWD|sed 's/^\///g'|rev|cut -f1 -d"/"|rev`
outfile=`grep "outfile = " $ctl|awk '{print $3}'`
tree=`grep "treefile = " $ctl|awk '{print $3}'`
echo 'library(ape)' > splittime.r
echo 'library(reshape2)' >> splittime.r
echo 'a<-read.tree("'$tree'")' >> splittime.r
echo 'cophenetic(a)->v' >> splittime.r
echo 'subset(melt(v), value!=0)->v1' >> splittime.r
echo 'v1$value= round(v1$value/2,digit=2)' >> splittime.r
echo 'write.table(v1,file="pairwise.txt",quote=F,sep="\t",row.names=F,col.names=F)' >> splittime.r
chmod a+x splittime.r
Rscript splittime.r
rm split_time.txt
sed -e 's/(/\n/g' -e 's/)/\n/g' -e 's/:/\n/g' -e 's/,/\n/g' $tree |grep "^[A-Z]" |grep -v "#"  > bg.txt
sed -e 's/(/\n/g' -e 's/)/\n/g' -e 's/:/\n/g' -e 's/,/\n/g' $tree|grep "[A-Z]"|grep "#"|awk '{print $1,$2}' OFS="\t" > fg_species
omval=`grep "(dN/dS)" $outfile|cut -f2 -d ":"`
mdl=`grep "Codon frequency model:" $outfile|awk -F ":" '{print $2}'|awk '{print $1}'`
lnlbf=`grep "lnL" $outfile|awk '{print $5}'`
npbf=`grep "lnL" $outfile|awk '{print $4}'|cut -f1 -d ")"`
bgspecies=`sed -e 's/(/\n/g' -e 's/)/\n/g' -e 's/,/\n/g' -e 's/:/\n/g' $tree|grep "[A-Z]" |grep -v "#" |awk '{print $1}'|tr '\n' ','|sed 's/,$/\n/g'` 
while read j
do
fgsp=`echo $j|awk '{print $1}'`
hs=`echo $j|awk '{print $2}' |sed 's/#//g'`
wm=`echo $omval|awk '{print $(var+1)}' var=$hs`
echo "$fgsp $hs $spomega" 
for bg in `cat bg.txt`
do 
grep "$fgsp" pairwise.txt |grep "$bg" >> fg.pairwise.txt
done
split=`cut -f3 fg.pairwise.txt |sort -n|head -n1`
echo -e "$fgsp\t$split" >> split_time.txt
rm fg.pairwise.txt
tm=`grep "$fgsp" split_time.txt|awk '{print $2}'`
wf=`echo $omval|awk '{print $1}'`
tf=`echo $tm $wm $wf | awk '{print $1*(($2 - 1)/($3 - 1))}'`
tp=`echo $tm $tf|awk '{print $1 - $2}'`
tf2=`echo $tm $tf $tp|awk '{print ($1*$2)/($2+(0.7*$3))}'`
tp2=`echo $tm $tf2|awk '{print $1-$2}'`
echo -e "$dir\t$fgsp\t$bgspecies\t$mdl\t$tm\t$wf\t$wm\t$tf\t$tp\t$tf2\t$tp2" >> ../outfilecompile
done < fg_species
done
