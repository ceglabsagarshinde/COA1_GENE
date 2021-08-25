echo -e "dir\tmdl\tfgspecies\tbgspecies\tom0\tlnlm0\tnpm0\tombnfg\tombnbg\tlnlbn\tnpbn\tombffg\tombfbg\tlnlbf\tnpbf" > compiled_result.txt
for dir in `ls -d */|sed 's/\///g'`
do
echo "$dir" > filename.txt
j=`grep -c "dupl\|group\|psuedo" filename.txt`
if [ $j -gt 0 ]
then
cp for_duplicate.sh $dir
else
cp for_functional.sh $dir
fi
cd $dir
echo $dir
cp input_files/*.fa input_files/*.nwk input_files/demo.ctl .
run_script=`ls *.sh`
bash $run_script
ls *M0.out|cut -f1,2 -d "_"|sort -u > speciesnames
for sp in `cat speciesnames`
do
for cf in F1x4 F3x4
do
for m0 in `ls "$sp"*_"$cf"_M0.out`
do
mdl=`grep "Codon frequency model:" $m0|awk -F ":" '{print $2}'|awk '{print $1}'`
om0=`grep "(dN/dS)" $m0|awk '{print $4}'`
lnlm0=`grep "lnL" $m0|awk '{print $4}' FS=':'|awk '{print $1}' FS=')'|awk '{print $1}'`
npm0=`grep "lnL" $m0|awk '{print $3}' FS=':'|awk '{print $1}' FS=')'|awk '{print $1}'`
done
for bfree in `ls "$sp"*_"$cf"_bfree.out`
do
ombffg=`grep "(dN/dS)" $bfree|awk '{print $6}'`
ombfbg=`grep "(dN/dS)" $bfree|awk '{print $5}'`
lnlbf=`grep "lnL" $bfree|awk '{print $4}' FS=':'|awk '{print $1}' FS=')'|awk '{print $1}'`
npbf=`grep "lnL" $bfree|awk '{print $3}' FS=':'|awk '{print $1}' FS=')'|awk '{print $1}'`
done
for bneutral in `ls "$sp"*_"$cf"_bneutral.out`
do
ombnfg=`grep "(dN/dS)" $bneutral|awk '{print $6}'`
ombnbg=`grep "(dN/dS)" $bneutral|awk '{print $5}'`
lnlbn=`grep "lnL" $bneutral|awk '{print $4}' FS=':'|awk '{print $1}' FS=')'|awk '{print $1}'`
npbn=`grep "lnL" $bneutral|awk '{print $3}' FS=':'|awk '{print $1}' FS=')'|awk '{print $1}'`
bgspecies=`grep -A1 "w ratios as labels for TreeView" $bneutral|tail -n1|sed -e 's/(/\n/g' -e 's/)/\n/g' -e 's/,/\n/g'|grep "[A-Z]"|awk '{print $1"\t"$2}'|grep -v "#1"|awk '{print $1}'|tr '\n' ','|sed 's/,$/\n/g'`
fgspecies=`grep -A1 "w ratios as labels for TreeView" $bneutral|tail -n1|sed -e 's/(/\n/g' -e 's/)/\n/g' -e 's/,/\n/g'|grep "[A-Z]"|awk '{print $1"\t"$2}'|grep "#1"|awk '{print $1}'`
done
echo -e "$dir\t$mdl\t$fgspecies\t$bgspecies\t$om0\t$lnlm0\t$npm0\t$ombnfg\t$ombnbg\t$lnlbn\t$npbn\t$ombffg\t$ombfbg\t$lnlbf\t$npbf" >> ../compiled_result.txt
done
done
cd ..
done
echo 'b<-read.table("compiled_result.txt",header=F,skip=1,sep="\t")' > likelihood.r
echo 'd<-as.data.frame(matrix(ncol = 15, nrow = 0))' >> likelihood.r

echo 'colnames(d)<-colnames(b)' >> likelihood.r
echo 'l=dim(b)[1]' >> likelihood.r
echo 'for (i in seq (1,l,1)){' >> likelihood.r
echo 'c=b[i,]' >> likelihood.r
echo 'c$pvalm0_bfree<-pchisq(2*(c$V14-c$V6),df=c$V15-c$V7,lower.tail=F)' >> likelihood.r
echo 'c$pavalbne_bfree<-pchisq(2*(c$V14-c$V10),df=c$V15-c$V11,lower.tail=F)' >> likelihood.r
echo 'd<-rbind(d,c)' >> likelihood.r
echo '}' >> likelihood.r
echo 'write.table(d,file="Final_result.txt",quote=F,sep="\t",col.names=F,row.names=F)' >> likelihood.r

Rscript likelihood.r

## Kindly remove these files before hand and only input_files folders should be present in each of these folder for running the wrapper_script_branch_test.sh script.
#rm */*.nwk */*.seq */*.fa* */*.aln */*.ctl */*.txt */speciesnames */cffile */model_details */*.sh */*.r
