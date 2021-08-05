###Running branch models on Carnivore duplicated gene species#####
##Acinonyx_jubatus has two copies of the gene and both are pseudogenized so the names of the copies is given as Acinonyx_jubatus2a and Acinonyx_jubatus2b, while for other species, the functional copy has species name in the fasta file and non-functional copy has "2" after the species name in the header
#our initial file is Carnivore_all.fa
sed -e '/^>/s/$/@/' -e 's/^>/#/' Carnivore_all.fa|sed '/^$/d' | sed 's/ //g'|tr -d '\n' |sort| tr "#" "\n" | tr "@" "\t"|sed '/ /d'|sed '/^$/d'|sed 's/^/>/g'|sed 's/\t/\n/g' > Carnivore_all.fa.fasta
grep ">" Carnivore_all.fa.fasta|wc -l #it is 52
##Making list of species for species tree from TimeTree
grep ">" Carnivore_all.fa.fasta|sed 's/>//g'|sed 's/2a//g'|sed 's/2b//g'|sed 's/2//g'|sed 's/_/ /g'|sort -u > all_species_for_tree.txt
##removing internode labels from the tree
sed -e "s/'[^()]*'//g" carnivore_duplicated.nwk > temp.nwk
mv temp.nwk carnivore_duplicated.nwk
##checking if species in tree and fasta file are equal
sed -e 's/(/\n/g' -e 's/)/\n/g' -e 's/:/\n/g' -e 's/;/\n/g' -e 's/,/\n/g' -e '/^$/d' *nwk|grep "^[A-Z]" > tree_species
grep ">" Carnivore_all.fa.fasta|sed 's/>//g'|sed 's/2a//g'|sed 's/2b//g'|sed 's/2//g'|sort -u > fasta.species
###The below command is important because TimeTree changed the name of species
sed -i 's/Monachus_schauinslandi/Neomonachus_schauinslandi/g' carnivore_duplicated.nwk
rm tree_species fasta.species
grep ">" Carnivore_all.fa.fasta |grep 2|sed 's/>//g' > pseudo.list
grep ">" Carnivore_all.fa.fasta |grep -v 2|sed 's/>//g' > functional.list
cp pseudo.list backup_pseudo.list
cp functional.list backup_functional.list
guidance=/Path/to/guidance.pl
echo -e "2\tF3x4\n1\tF1x4" > cffile
echo -e 'M0\t0\t0\t0.4\nbfree\t2\t0\t0.4\nbneutral\t2\t1\t1' > model_details
##making separate fasta file for pseudo and functional genes
for i in `cat pseudo.list`
do
grep -A1 "\b$i\b"  Carnivore_all.fa.fasta|sed 's/-//g' >> pseudo.fasta
done

for i in `cat functional.list`
do
grep -A1 "\b$i\b"  Carnivore_all.fa.fasta|sed 's/-//g' >> functional.fasta
done

sed -i '/^$/d' *.fasta

##Please keep demo.ctl in the working directory
for i in `cat pseudo.list`
do
j=`echo $i|cut -f1 -d "2"`
grep -A1 "$i" pseudo.fasta > $i.seq
sed -e "/$j/,+1d" functional.fasta > "$i"_functional.fa
cat "$i"_functional.fa >> $i.seq
rm "$i"_functional.fa
sed -i "s/$i/$j/g" $i.seq
grep ">" $i.seq |sed 's/>//g' > list.txt
perl $guidance --program GUIDANCE --seqFile "$i".seq --msaProgram PRANK --seqType codon --outDir "$i".100_PRANK --genCode 1 --bootstraps 100 --proc_num 16
cp "$i".100_PRANK/MSA.PRANK.aln.With_Names $i.aln
done
tree=carnivore_duplicated.nwk
for i in `cat pseudo.list`
do
j=`echo $i|cut -f1 -d "2"`
grep ">" $i.seq |sed 's/>//g' > list.txt
echo 'library(ape)' > pruning.r
echo 'a<-read.tree("'$tree'")' >> pruning.r
echo 'b<-read.table("list.txt")' >> pruning.r
echo 'c<-as.character(b$V1)' >> pruning.r
echo 'd<-keep.tip(a,c)' >> pruning.r
echo 'write.tree(d,file="'$i.nwk'")' >> pruning.r
chmod 777 pruning.r
Rscript pruning.r
sed -i "s/$j/$j #1/g" $i.nwk
done

for i in `cat pseudo.list`
do
j=`echo $i|cut -f1 -d "2"`
for m in M0 bfree bneutral
do
for cf in F3x4 F1x4
do
CF=`grep "$cf" cffile|cut -f1`
x=`echo "$i"_"$cf"_"$m"`
cp demo.ctl "$x".ctl
sed -i "s/ssssss/$i.aln/g" $x.ctl
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
##############################
