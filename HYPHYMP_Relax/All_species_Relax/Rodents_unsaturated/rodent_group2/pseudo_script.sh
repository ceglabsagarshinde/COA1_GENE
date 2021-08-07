for i in *.aln
do
sed -e '/^>/s/$/@/' -e 's/^>/#/' $i | tr -d '\n' |sort| tr "#" "\n" | tr "@" "\t"| sed -e 's/^/>/'|sed '1d' -|sed 's/\t/\n/g' > $i.faa
done
############################################# do this when we have list of species having pseudogene and functional gene ##############################################
## Create the functional and pseudogene species list manually and labelling to forground species

for i in `cat list_functional.txt`
do
j=`ls *faa`
grep -A1 "$i" $j >> functional.fa
done
tree=`ls *.nwk`
for i in `cat list_psedo.txt`
do
j=`ls *.faa`
grep -A1 "$i" $j > $i.seq
cat functional.fa  >> $i.seq
grep ">" $i.seq |sed 's/>//g' > list.txt
echo 'library(ape)' > pruning.r
echo 'a<-read.tree("'$tree'")' >> pruning.r
echo 'b<-read.table("list.txt")' >> pruning.r
echo 'c<-as.character(b$V1)' >> pruning.r
echo 'd<-keep.tip(a,c)' >> pruning.r
echo 'write.tree(d,file="'$i.nwk'")' >> pruning.r
chmod 777 pruning.r
Rscript pruning.r
sed -i "s/$i/$i{fg}/g" $i.nwk
done 


#making the HYPHYMP config file for relax test
for i in  `cat  list_psedo.txt`
do
seq="$i".seq
tree="$i".nwk
echo -ne  "1\n7\n1\n"$PWD"/$seq\n"$PWD"/"$tree"\n2\n2" > "$i"_tree.config
done

##Running the HYPHYMP for relax test
for i in *config
do
HYPHYMP  <  $i > $i.out
done

#taking a output in single file
for j in `ls -1 *out`
do
pval=`grep "^Like" $j|awk '{print $6}'|sed 's/\*\*\.//g'`
kval1=`grep "Relaxation/intensification" $j|awk '{print $6}'|head -1`
test=`grep "_test_ set:" $j|awk '{print $9}'|sed 's/\`//g'`
back=`grep "_reference_ set:" $j|cut -f2 -d ":"|sed 's/ //g'`
echo $test $back $pval $kval1 >>Rodents_grp2_results.txt
done

