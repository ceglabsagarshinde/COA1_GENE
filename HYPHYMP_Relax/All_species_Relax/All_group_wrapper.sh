for j in `cat list.functional`
do
cd $j
chmod 777 relax.sh
./relax.sh $j
cd -
done

for j in `cat list.pseudogene`
do
cd $j
chmod 777 pseudo_script.sh
./pseudo_script.sh $j
cd -
done

for i in `cat list.duplicate`
do
cd $j
chmod 777 duplication_relax.sh
./duplication_relax.sh $j
cd -
done

