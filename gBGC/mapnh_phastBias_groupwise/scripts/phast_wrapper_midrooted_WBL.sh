for d in Birds_groups
do
cd $d
for j in `cat list_birds.group`
do
cd $j
chmod 777 mapnh.sh phast.sh
gotree reroot midpoint -i "$j".nwk -o temp.nwk
rm "$j".nwk
mv temp.nwk "$j".nwk
./phast.sh $j
cd -
done
done

cd ../

for j in `cat list.file`
do
cd $j
chmod 777 mapnh.sh phast.sh
gotree reroot midpoint -i "$j".nwk -o temp.nwk
rm "$j".nwk
mv temp.nwk "$j".nwk
./phast.sh $j
cd -
done


for d in Rodents_unsaturated
do
cd $d
for j in `cat list.rodent`
do
cd $j
chmod 777 mapnh.sh phast.sh
gotree reroot midpoint -i "$j".nwk -o temp.nwk
rm "$j".nwk
mv temp.nwk "$j".nwk
./phast.sh $j
cd -
done
done

cd ../
