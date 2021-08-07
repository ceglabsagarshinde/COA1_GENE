## Calculate GC % in COA1 and PDX1 gene
As mentioned in supplementary materials and method, we used CODESEQgene window-based software to calculate the possible higher and lower GC in both genes in different species.
We made two txt files for two genes in which species name and possible low and high GC % is mention which we provided the group of species belongs to primate and rodents.
All species are not the same in both genes, but the number of species is the same.
Similarly, for both the genes, we downloaded the species tree from TimeTree.
plotted the figure in using contmap Rsript provifed in folder

command used:
CodSeqGen.exe -l d -n 10 -aa $i -gc 48.35 >$i.out.txt
