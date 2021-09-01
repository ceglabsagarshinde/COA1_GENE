###This script is to test the effect of inclusion of more number of species on pseudogenization timing estimation in birds with background in different combinations
###Initial files are birds.fa birds_unrooted.nwk birds_F3x4.ctl birds_F1x4.ctl
sed -e '/^>/s/$/@/' -e 's/^>/#/' birds.fa|sed '/^$/d' | sed 's/ //g'|tr -d '\n' |sort| tr "#" "\n" | tr "@" "\t"|sed '/ /d'|sed '/^$/d'|sed 's/^/>/g'|sed 's/\t/\n/g' > birds.faa
guidance=/path/to/guidance.pl
sed -e 's/(/\n/g' -e 's/,/\n/g' -e 's/)/\n/g' birds.nwk|grep "^[A-Z]" > species_list.txt
rm -r upto_*
for n in 24 30 33 39 43 51 58 67 71 73 79 85 91 96 99
do
head -n"$n" species_list.txt > partlist
sp=`head -n"$n" species_list.txt|tail -n1`
mkdir upto_"$sp"
for i in `cat partlist`
do
grep -A1 "$i" birds.faa >> part.fa
done
tree=birds.nwk
echo 'library(ape)' > pruning.r
echo 'a<-read.tree("'$tree'")' >> pruning.r
echo 'b<-read.table("partlist")' >> pruning.r
echo 'c<-as.character(b$V1)' >> pruning.r
echo 'd<-keep.tip(a,c)' >> pruning.r
echo 'write.tree(d,file="'part.nwk'")' >> pruning.r
chmod 777 pruning.r
Rscript pruning.r
sed -i 's/Odontophorus_gujanensis),(Coturnix_japonica,((Meleagris_gallopavo,((Lyrurus_tetrix,(Tympanuchus_cupido,Centrocercus_minimus)),Lagopus_muta)),((Pavo_cristatus,Gallus_gallus),((Chrysolophus_pictus,Phasianus_colchicus),Syrmaticus_mikado))))),Numida_meleagris)/Odontophorus_gujanensis#1),(Coturnix_japonica#1,((Meleagris_gallopavo#1,((Lyrurus_tetrix#2,(Tympanuchus_cupido#2,Centrocercus_minimus#2)#2)#2,Lagopus_muta#2)#1),((Pavo_cristatus#1,Gallus_gallus#1),((Chrysolophus_pictus,Phasianus_colchicus),Syrmaticus_mikado#1))))),Numida_meleagris#1)/g' part.nwk
mv part.nwk part.fa upto_"$sp"
cd upto_"$sp"
perl $guidance --program GUIDANCE --seqFile part.fa --msaProgram PRANK --seqType codon --outDir part.fa.100_PRANK --genCode 1 --bootstraps 100 --proc_num 16
cp part.fa.100_PRANK/MSA.PRANK.aln.With_Names upto_"$sp".aln
cd ..
done

for dir in `ls -d upto_* | sed 's/\///g'`
do
cp birds_F3x4.ctl "$dir"
cp birds_F1x4.ctl "$dir"
cd $dir
sed -i "s/ssssss/$dir/g" birds_F3x4.ctl
sed -i "s/ssssss/$dir/g" birds_F1x4.ctl
codeml birds_F3x4.ctl
codeml birds_F1x4.ctl
cd ..
done

###compiling the results
echo -e "Odontophorus_gujanensis\t19.84\nCoturnix_japonica\t45.85\nMeleagris_gallopavo\t20.73\nLyrurus_tetrix\t6.83\nTympanuchus_cupido\t6.16\nCentrocercus_minimus\t6.16\nLagopus_muta\t11.69\nPavo_cristatus\t32.98\nGallus_gallus\t32.98\nSyrmaticus_mikado\t16.71\nNumida_meleagris\t46.52" > splittime
echo -e "Foreground\tBackgrounds\tnBg\tmodel\tTm\twf\twm\twp\tTf\tTp\tTf2\tTp2" > outfilecompile
for n in 24 30 33 39 43 51 58 67 71 73 79 85 91 96 99
do
head -n"$n" species_list.txt > species
sp=`head -n"$n" species_list.txt|tail -n1`
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
cp background_effect.pdf ../birds_bg_combination_effect.pdf
