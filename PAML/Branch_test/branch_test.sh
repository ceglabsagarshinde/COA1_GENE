## This folder contains branch-test files and results.
# The nwk file is the species tree downloaded from timetree.org and the name replaced by TimeTree in it have been modified.
# to remove internode labels from the TimeTree nwk file
for i in *.nwk
do
sed -e "s/'[^()]*'//g" $i > temp.nwk
mv temp.nwk $i
done

# This script check whether the species name in the fasta file and nwk file are same or not.
for i in *.fa
do
grep ">" $i|sed 's/>//g' > $i.txt
j=`ls *.nwk`
sed 's/(/\n/g' $j|sed 's/)/\n/g' |sed 's/;/\n/g' |sed 's/:/\n/g' |sed 's/,/\n/g' |grep "^[A-Z]" > $j.txt
echo $j
cat $i.txt $j.txt |sort|uniq -c |awk '$1<2 {print $2}'
rm *.txt
done


# made groupwise folder and do alignment
guidance=/Path/to/guidance.pl
for i in *.fa
do
j=`echo $i|sed 's/.fa//g'`
mkdir $j
mv $j.* $j/
cd $j
perl $guidance --program GUIDANCE --seqFile "$i" --msaProgram PRANK --seqType codon --outDir "$i".100_PRANK --genCode 1 --bootstraps 100 --proc_num 16
cp "$i".100_PRANK/MSA.PRANK.aln.With_Names $j.aln
cd ../
done

## For making alingment file into two line fasta file
for i in *.aln
do
sed -e '/^>/s/$/@/' -e 's/^>/#/' $i | tr -d '\n' |sort| tr "#" "\n" | tr "@" "\t"| sed -e 's/^/>/'|sed '1d' -|sed 's/\t/\n/g' > $i.faa
done

## For taking one species as a foregorund and rest as background
echo -e "2\tF3x4" > cffile
echo -e "1\tF1x4" >> cffile
echo -e 'M0\t0\t0\t0.4\nbfree\t2\t0\t0.4\nbneutral\t2\t1\t1' > model_details

## labelling foreground species in tree and running branch model using PAML. 
for i in `grep ">" *.aln.faa |sed 's/>//g'`
do
sed "s/$i/$i #1/g" *.nwk > $i.nwk
for m in M0 bfree bneutral
do
for cf in F3x4 F1x4
do
CF=`grep "$cf" cffile|cut -f1`
x=`echo "$i"_"$cf"_"$m"`
cp demo.ctl "$x".ctl
sed -i "s/ssssss/$i/g" $x.ctl
sed -i "s/tttttt/$i.nwk/g" $x.ctl
sed -i "s/CF/$CF/g" $x.ctl
sed -i "s/oooooo/$x.out/g" $x.ctl
mdl=`grep "$m" model_details|awk '{print $2}'`
FO=`grep "$m" model_details|awk '{print $3}'`
OMG=`grep "$m" model_details|awk '{print $4}'`
sed -i "s/mdl/$mdl/g" $x.ctl
sed -i "s/FO/$FO/g" $x.ctl
sed -i "s/OMG/$OMG/g" $x.ctl
codeml $x.ctl
done
done
done

### for compiling results 
for i in `grep ">" *.aln |sed 's/>//g'`
do
for m in M0 bfree bneutral
do
for cf in F3x4 F1x4
do
mkdir $i $i/$m
cp $i*$m* $i/$m 
done
done
done

##############################
for i in *M0*out
do 
echo $i
j=`echo $i|sed 's/.M0.out//g'`
a=`grep "(dN/dS)" $i |awk -F ' ' '{print $4}'`
b=`grep "np:" $i|awk '{print $2}' |sed 's/)://g'`
lnL=`grep "np:" $i|awk '{print $3}'`
echo "$j\t$a\t$b\t$lnL" >> M0.txt
sed -i 's/\\t/\t/g' M0.txt
done

for i in *bfree*out
do
echo $i
j=`echo $i|sed 's/.out//g'`
a=`grep "(dN/dS)" $i |awk -F ' ' '{print $6}'`
b=`grep "np:" $i|awk '{print $2}' |sed 's/)://g'`
lnL=`grep "np:" $i|awk '{print $3}'`
echo "$a\t$b\t$lnL" >> bfree.txt
sed -i 's/\\t/\t/g' bfree.txt
done


for i in *bneutral*out
do
echo $i
j=`echo $i|sed 's/.out//g'`
a=`grep "(dN/dS)" $i |awk -F ' ' '{print $6}'`
b=`grep "np:" $i|awk '{print $2}' |sed 's/)://g'`
lnL=`grep "np:" $i|awk '{print $3}'`
echo "$a\t$b\t$lnL" >> bneutral.txt
sed -i 's/\\t/\t/g' bneutral.txt
done

paste M0.txt bneutral.txt bfree.txt > Result.txt

sed 's/	_F/\tF/g' Result.txt |awk '{print $2,$1,$3,$4,$5,$6,$7,$8,$9,$10,$11}' |sed 's/ /\t/g' >Final_result.txt 

## for foregorund species list
grep ">" Canis_lupus2.seq|sed 's/>//g'|sed -z 's/\n/, /g' > background.txt
cut -f2 Final_result.txt |sed 's/2.seq//g' > 2.txt
for i in `cat 2.txt` 
do
sed "s/$i, //g" background.txt |sed 's/..$//g'
done

