for j in `cat list.functional`
do
cd $j
./relax.sh $j
cd -
done

for j in `cat list.pseudogene`
do
cd $j
./pseudo_script.sh $j
cd -
done

for i in `cat list.duplicate`
do
cd $j
./duplication_relax.sh $j
cd -
done

