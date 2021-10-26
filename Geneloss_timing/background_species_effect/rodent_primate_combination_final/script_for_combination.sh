###This script is to test the effect of inclusion of more number of species on pseudogenization timing estimation in Rodents with Primates as background in different combinations
guidance=/home/nagarjun/guidance.v2.02/www/Guidance/guidance.pl
rm -r upto_*
echo -e "Oryctolagus_cuniculus\nHeterocephalus_glaber\nCastor_canadensis" > hashone
echo -e "Spermophilus_dauricus\nIctidomys_tridecemlineatus\nMarmota_marmota\nUrocitellus_parryii" > hashtwo
echo -e ":3.4797025\n:2.702455" > internodehashtwo
echo -e ":23.37229" > internodehashone
for n in 18 22 24 26 29 30 32 33 35 37 38 40 41 42 43
do
head -n"$n" rodent_primate_combination.txt > partlist
sp=`head -n"$n" rodent_primate_combination.txt|tail -n1`
mkdir upto_"$sp"
for i in `cat partlist`
do
grep -A1 "$i" rodent_primate_combination.fa >> part.fa
done
tree=rodent_primate_combination.nwk
echo 'library(ape)' > pruning.r
echo 'a<-read.tree("'$tree'")' >> pruning.r
echo 'b<-read.table("partlist")' >> pruning.r
echo 'c<-as.character(b$V1)' >> pruning.r
echo 'd<-keep.tip(a,c)' >> pruning.r
echo 'write.tree(d,file="'part.nwk'")' >> pruning.r
chmod 777 pruning.r
Rscript pruning.r
for h in `cat hashone`
do
sed -i "s/$h/$h #1/g" part.nwk
done
for h in `cat hashtwo`
do
sed -i "s/$h/$h #2/g" part.nwk
done
for h in `cat internodehashtwo`
do
sed -i "s/$h/#2$h/g" part.nwk
done
for h in `cat internodehashone`
do
sed -i "s/$h/#1$h/g" part.nwk
done
mv part.nwk part.fa upto_"$sp"
cd upto_"$sp"
perl $guidance --program GUIDANCE --seqFile part.fa --msaProgram PRANK --seqType codon --outDir part.fa.100_PRANK --genCode 1 --bootstraps 100 --proc_num 16
cp part.fa.100_PRANK/MSA.PRANK.aln.With_Names upto_"$sp".aln
cd ..
done

for dir in `ls -d upto_* | sed 's/\///g'`
do
cp Primates_rodents_F3x4.ctl "$dir"
cp Primates_rodents_F1x4.ctl "$dir"
cd $dir
sed -i "s/ssssss/$dir/g" Primates_rodents_F3x4.ctl
sed -i "s/ssssss/$dir/g" Primates_rodents_F1x4.ctl
codeml Primates_rodents_F3x4.ctl
codeml Primates_rodents_F1x4.ctl
cd ..
done

###compiling the results
echo -e "Heterocephalus_glaber\t33.83\nCastor_canadensis\t70.54\nUrocitellus_parryii\t34.7\nSpermophilus_dauricus\t34.7\nIctidomys_tridecemlineatus\t34.7\nMarmota_marmota\t34.7\nOryctolagus_cuniculus\t51.43" > splittime
echo -e "Foreground\tBackgrounds\tnBg\tmodel\tTm\twf\twm\twp\tTf\tTp\tTf2\tTp2" > outfilecompile
for n in 18 22 24 26 29 30 32 33 35 37 38 40 41 42 43
do
head -n"$n" rodent_primate_combination.txt > species
sp=`head -n"$n" rodent_primate_combination.txt|tail -n1`
while read j
do
fg=`echo $j|awk '{print $1}'`
sed -i "/$fg/d" species
done < splittime
bg=`cat species|tr '\n' ','|sed 's/,$/\n/g'`
nbg=`wc -l species|awk '{print $1}'`
cd upto_"$sp"
for out in `ls upto_*_single_omega_mix_functional_*`
do
model=`echo $out|awk -F_ '{print $NF}'`
wf=`grep "w (dN/dS) for branches:" $out|awk '{print $5}'`
wm=`grep "w (dN/dS) for branches:" $out|awk '{print $6}'`
wp=`grep "w (dN/dS) for branches:" $out|awk '{print $7}'`
while read j
do
fg=`echo $j|awk '{print $1}'`
tm=`echo $j|awk '{print $2}'`
tf=`echo $tm $wm $wf | awk '{print $1*(($2 - 1)/($3 - 1))}'`
tp=`echo $tm $tf|awk '{print $1 - $2}'`
tf2=`echo $tm $tf $tp|awk '{print ($1*$2)/($2+(0.7*$3))}'`
tp2=`echo $tm $tf2|awk '{print $1-$2}'`
echo -e "$fg\t$bg\t$nbg\t$model\t$tm\t$wf\t$wm\t$wp\t$tf\t$tp\t$tf2\t$tp2" >> ../outfilecompile
done < ../splittime
done
cd ..
rm species
done

Rscript background_combination_plot.r
cp Bg_combination.jpeg ../rodents_bg_effect_combination.jpeg

