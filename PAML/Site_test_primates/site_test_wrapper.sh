for i in 27primates
do 
cd $i
chmod 777 sitemodel.sh
./sitemodel.sh
cd -
done

for j in 9_primates_with_different_phylogeny
do 
cd $j
for i in `cat list.file`
do 
cd $i
chmod 777 site_model_compare_trees.sh
./site_model_compare_trees.sh
cd -
done
done
cd ../
