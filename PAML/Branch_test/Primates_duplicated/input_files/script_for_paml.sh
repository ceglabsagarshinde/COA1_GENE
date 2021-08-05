## *_all.fa is the initial multi fasta file which contains gene sequence of functional as well as non-functional copy.
## Functional copies are represented with species name while non-functional copy has species name followed by 2 at its end in the headers.
## In case of a species having more than one non-functional copy, 2a and 2b are used.
grep ">" *_all.fa |grep -v "2" |sed 's/>//g' > functional.txt
grep ">" *_all.fa |grep "[0-9]" |sed 's/>//g' > pseudogene.txt

for i in `cat functional.txt` ; do grep -A1 "\b$i\b" *_all.fa >> functional.fa; done
for i in `cat pseudogene.txt` ; do grep -A1 "\b$i\b" *_all.fa >> pseudogene.fa; done 
guidance=/Path/to/guidance.pl

for i in `cat pseudogene.txt`
do
j=`echo $i|cut -f 1 -d '2'`
grep -A1 "\b$i\b" pseudogene.fa > $i.seq
sed -e "/$j/,+1d" functional.fa > functional.faa
cat functional.faa  >> $i.seq
sed -i "s/$i/$j/g" $i.seq
done

for i in *.seq
do
perl $guidance --program GUIDANCE --seqFile "$i" --msaProgram PRANK --seqType codon --outDir "$i".100_PRANK --genCode 1 --bootstraps 100 --proc_num 16
cp "$i".100_PRANK/MSA.PRANK.aln.With_Names $i.fasta
done

## making input tree file
for i in *.nwk
do
sed -e "s/'[^()]*'//g" $i > temp.nwk
mv temp.nwk $i
done
tree=`ls *.nwk`
for i in *.fasta
do
j=`echo $i|cut -d '2' -f1`
k=`echo $i|sed 's/.fasta//g'`
grep ">" $i |sed 's/>//g' > $i.list
echo 'library(ape)' > pruning.r
echo 'a<-read.tree("'$tree'")' >> pruning.r
echo 'b<-read.table("'$i.list'")' >> pruning.r
echo 'c<-as.character(b$V1)' >> pruning.r
echo 'd<-keep.tip(a,c)' >> pruning.r
echo 'write.tree(d,file="'$k.nwk'")' >> pruning.r
chmod 777 pruning.r
Rscript pruning.r
sed -i "s/$j/$j #1/g" $k.nwk
done


echo -e "2\tF3x4" > cffile
echo -e "1\tF1x4" >> cffile
echo -e 'M0\t0\t0\t0.4\nbfree\t2\t0\t0.4\nbneutral\t2\t1\t1' > model_details

## Now making the control file and running PAML.
for i in *.fasta
do
j=`echo $i|sed 's/.fasta//g'`
for m in M0 bfree bneutral
do
for cf in F3x4 F1x4
do
CF=`grep "$cf" cffile|cut -f1`
x=`echo "$j"_"$cf"_"$m"`
cp demo.ctl "$x".ctl
sed -i "s/ssssss/$i/g" $x.ctl
sed -i "s/tttttt/$j.nwk/g" $x.ctl
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
