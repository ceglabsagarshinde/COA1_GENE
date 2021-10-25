for i in 27primates
do
cd $i
chmod 777 sitemodel.sh
bash sitemodel.sh
cd -
done

for j in 9_primates_with_different_phylogeny
do
cp site_model_compare_trees.sh $j
cd $j
for i in `cat list.file`
do
cd $i
chmod 777 site_model_compare_trees.sh
bash site_model_compare_trees.sh
cd -
done
done
cd ../
