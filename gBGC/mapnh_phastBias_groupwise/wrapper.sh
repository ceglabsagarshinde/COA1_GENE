####for phastBias ###################################

for d in Birds_groups
do
cd $d
for j in `cat list_birds.group`
do 
cd $j
chmod 777 mapnh.sh phast.sh
./mapnh.sh $j
./phast.sh $j
cd - 
done
done

cd ../

for j in `cat list.file`
do 
cd $j 
chmod 777 mapnh.sh phast.sh
./mapnh.sh $j
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
./mapnh.sh $j
./phast.sh $j
cd - 
done
done

cd ../

######################################################
#collect output 
rm -r output_phastbias_mapnh
mkdir output_phastbias_mapnh 
for j in `cat list.file`;
do 
cd $j;
cp $j *.phast.out ../output_phastbias_mapnh/
cd -
done

for d in Rodents_unsaturated
do
cd $d
for j in `cat list.rodent`
do 
cd $j
cp $j *.phast.out ../../output_phastbias_mapnh/
cd - 
done
done

cd ../

for d in Birds_groups
do
cd $d
for j in `cat list_birds.group`
do 
cd $j
cp $j *.phast.out ../../output_phastbias_mapnh/
cd - 
done
done

cd ../
cd output_phastbias_mapnh
cp ../script.sh ../gBGC.R ../transpose.sh ../ploting.sh . 
chmod 777 script.sh gBGC.R transpose.sh ploting.sh

##make different groups from 1 big group 
./script.sh 10 Amphibian_Reptiles Amphibian_Reptiles.aln.phast.out
./script.sh 12 Artiodactyla Artiodactyla.aln.phast.out
./script.sh  12 Birds_group2 Birds_group2.aln.phast.out
./script.sh  9  Birds_group3  Birds_group3.aln.phast.out
./script.sh  10 Birds_group4 Birds_group4.aln.phast.out
./script.sh  9 Birds_group6 Birds_group6.aln.phast.out
./script.sh 10 Caniformia Caniformia.aln.phast.out
./script.sh 10 Caniformia_duplicated Caniformia_duplicated.aln.phast.out
./script.sh 11 Primates Primates.aln.phast.out
./script.sh 11 Primates_duplicated Primates_duplicated.aln.phast.out


###remove the files
rm Amphibian_Reptiles Amphibian_Reptiles.aln.phast.out
rm Artiodactyla Artiodactyla.aln.phast.out
rm Birds_group2 Birds_group3 Birds_group4 Birds_group6 Birds_group2.aln.phast.out Birds_group3.aln.phast.out Birds_group4.aln.phast.out  Birds_group6.aln.phast.out
rm Caniformia Caniformia.aln.phast.out
rm Caniformia_duplicated Caniformia_duplicated.aln.phast.out
rm Primates Primates.aln.phast.out
rm Primates_duplicated Primates_duplicated.aln.phast.out

#reverse  transpose
for i in `ls *_phastout`;do ./transpose.sh $i >a;mv a $i ;done


##make same files
rename 's/.aln.phast.out/_phastout/g' *.out
rename 's/Amphibian_Reptiles_grouplast/Amphibian_Reptiles_group2/g' *
rename 's/Artiodactyla_grouplast/Artiodactyla_group2/g' * 
rename 's/Caniformia_duplicated_grouplast/Caniformia_duplicated_group2/g' *
rename 's/Caniformia_grouplast/Caniformia_group2/g' *
rename 's/Primates_duplicated_grouplast/Primates_duplicated_group2/g' *
rename 's/Primates_grouplast/Primates_group3/g' *
rename 's/Birds_group3_grouplast/Birds_group3_group2/g' *
rename 's/Birds_group2_grouplast/Birds_group2_group2/g' *
rename 's/Birds_group4_grouplast/Birds_group4_group3/g' *
rename 's/Birds_group6_grouplast/Birds_group6_group2/g' *


./ploting.sh




