## mapnh and phastBias results
Output from mapnh and phastBias collected in this folder for ploting. The file named by group only is comprised of the output of mapnh (column 2 = AT to GC  and 4=GC to AT),HYPHY (column 6 =dN and 8=dS),PAML (column 10 =dN and 12=dS). (*phastout) is output of phastBias. It contains gBGC across nucleotide position for each species.
The groups which have more number of species arew divided into different groups for better visualization we split the groups. The files containing groups name are used as input for plotting.
In order to grenerate figure:
For plotting code is given (gBGC.R).
example= Rscript gBGC.R Afrotheria and Rscript gBGC.R Birds_group1. 
