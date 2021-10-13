## This script will run codeml and compile the results of the gene loss timing estimation in Felliformes.
## The feliformia group on TimeTree shows different split time for Acinonyx jubatus and Puma concolor. According to the published science article "The Late Miocene Radiation of Modern Felidae: A Genetic Assessment", Acinonyx jubatus and Puma concolor diverged after the Felis catus. We used the tree provided in this article.
echo -e "Feliformia\tForeground\tBackgrounds\tmodel\tTm\twf\twm\tTf\tTp\tTf2\tTp2" > outfilecompile
for ctl in `ls *ctl`
do
rm codeml.ctl
codeml "$ctl"
tree=`ls -1 *nwk`
sed -e 's/(/\n/g' -e 's/)/\n/g' -e 's/:/\n/g' -e 's/,/\n/g' $tree |grep "^[A-Z]" |grep "#" |sed -e 's/#.*//g'  -e 's/ //g' > fg.txt 
sed -e 's/(/\n/g' -e 's/)/\n/g' -e 's/:/\n/g' -e 's/,/\n/g' $tree |grep "^[A-Z]" |grep -v "#"  > bg.txt 
outfile=`grep "outfile =" $ctl|awk '{print $3}'`
for sp in `cat fg.txt`
do
bg=`cat bg.txt|tr '\n' ','|sed 's/,$/\n/g'`
tm=5 #DIVERGENCE TIME TAKEN 5(MYA) FOR FOREGROUND
mdl=`grep "Codon frequency model:" $outfile|awk -F ":" '{print $2}'|awk '{print $1}'`
wf=`grep "w (dN/dS) for branches:" $outfile|awk '{print $5}'`
wm=`grep "w (dN/dS) for branches:" $outfile|awk '{print $6}'`
wp=`grep "w (dN/dS) for branches:" $outfile|awk '{print $7}'`
tf=`echo $tm $wm $wf | awk '{print $1*(($2 - 1)/($3 - 1))}'`
tp=`echo $tm $tf|awk '{print $1 - $2}'`
tf2=`echo $tm $tf $tp|awk '{print ($1*$2)/($2+(0.7*$3))}'`
tp2=`echo $tm $tf2|awk '{print $1-$2}'`
echo -e "$dir\t$sp\t$bg\t$mdl\t$tm\t$wf\t$wm\t$tf\t$tp\t$tf2\t$tp2" >> outfilecompile
rm codeml.ctl
done
done

