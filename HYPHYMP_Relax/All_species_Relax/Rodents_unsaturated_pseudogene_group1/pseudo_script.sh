k=$1

###make each sequence in single line  in single line 
for p in "$k".aln
do
sed -e '/^>/s/$/@/' -e 's/^>/#/' $p | tr -d '\n' |sort| tr "#" "\n" | tr "@" "\t"| sed -e 's/^/>/'|sed '1d' -|sed 's/\t/\n/g' > $p.faa
done
############################################# do this when we have list of species having pseudogene and functional gene ##############################################
## Create the functional and pseudogene species list manually

for i in `cat list_functional.txt`
do
j=`ls *faa`
grep -A1 "$i" $j >> functional.fa
done
tree="$k".nwk
for i in `cat list_pseudogene.txt`
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

rm *fa *faa
###making the config file for relax test ###########################################################################################

for b in `cat list_pseudogene.txt`
do
seq="$b".seq
tree="$b".nwk
echo -ne  "1\n7\n1\n"$PWD"/$seq\n"$PWD"/"$tree"\n2\n2" > "$b"_tree.config
done

####running the relax  using HYPHYMP ################################################################################################

for d in *config
do
HYPHYMP  <  $d > $d.out
done

#### keep the result in one file ################################################################################################################################

for f in `ls -1 *.out`
do
pval=`grep "^Like" $f|awk '{print $6}'|sed 's/\*\*\.//g'`
kval1=`grep "Relaxation/intensification" $f|awk '{print $6}'|head -1`
test=`grep "_test_ set:" $f|awk '{print $9}'|sed 's/\`//g'`
back=`grep "_reference_ set:" $f|cut -f2 -d ":"|sed 's/ //g'`
echo $test $back $pval $kval1 >> "$k".results.txt
done

#####################################################################################################################################

