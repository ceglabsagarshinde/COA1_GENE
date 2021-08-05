## Making folder by species and inside them different models. The respective control and output files are copied into their folders which are later removed after the compilation of results.

for i in `cat pseudogene.txt`
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


for i in *M0*out
do 
echo $i
j=`echo $i|sed 's/.M0.out//g'`
a=`grep  "(dN/dS)" $i |awk -F' ' '{print $4}'`
b=`grep "np:" $i|cut -d ":" -f3|sed 's/)//g'`
lnL=`grep "np:" $i|awk '{print $5}'`
echo "$j\t$a\t$b\t$lnL" >> M0.txt
sed -i 's/\\t/\t/g' M0.txt
done

for i in *bfree*out
do
echo $i
j=`echo $i|sed 's/.out//g'`
a=`grep "(dN/dS)" $i |awk -F' ' '{print $6}'`
b=`grep "np:" $i|cut -d ":" -f3|sed 's/)//g'`
lnL=`grep "np:" $i|awk '{print $5}'`
echo "$a\t$b\t$lnL" >> bfree.txt
sed -i 's/\\t/\t/g' bfree.txt
done


for i in *bneutral*out
do
echo $i
j=`echo $i|sed 's/.out//g'`
a=`grep "(dN/dS)" $i |awk -F' ' '{print $6}'`
b=`grep "np:" $i|cut -d ":" -f3|sed 's/)//g'`
lnL=`grep "np:" $i|awk '{print $5}'`
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

