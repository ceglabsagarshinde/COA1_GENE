#############Additional information###########
##This script is to look at the effect of inclusion of more number of background species on pseudogenization time estimation using Meredith et al. 2009 method.
##We looked the effect on (i) non-functioning COA1 birds as foreground with with combinations of functional COA1 birds as background, (ii) non-functioning COA1 rodents as foreground and different combinations of primates as background.
##Labelling of tree is mentioned in JPG, PNG and PDF format in the same directory. Inclusion of background species is according to clades, and not completely random. The scripts will also generate final compiled text file as well as the figure. Generating figure requires R.
##############################################
##Script starts here##
for dir in `ls -d */|sed 's/\///g'
do
cd $dir
bash script_for_combination.sh
cd ..
done

echo 'Run complete!! Please refer to the respective directories for the final results!!'
