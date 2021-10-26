##This is the overall wrapper script for gene loss time estimation in different species
##Each directory has their wrapper script inside. This script run those scripts, compile the results and generate the figure. Each wrapper script can be run individually also if one wishes to get the result of only one group.
for dir in `ls -d */|sed 's/\///g'`
do
cd $dir
for script in `ls -1 *sh`
do
chmod 777 $script
bash $script
done
cd ..
done

chmod 777 compiling_script.sh
bash compiling_script.sh
Rscript Pseudogenization_time_compile.r
