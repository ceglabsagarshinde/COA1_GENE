# COA1
COA1 is a four exonic gene that regulates cytochrome c oxidase assembly. Other names include Cytochrome C Oxidase Assembly Factor 1 Homolog, C7orf44 and MITRAC15 (mitochondrial translation regulation assembly intermediate of cytochrome c oxidase complex) complex.

The code and data provided in this project are part of the below manuscript. The scripts and data are organised to ensure the integrity, credibility and replicability of the results reported. However, the goal of this repository is not to release a fully-automate pipeline and is beyond the scope of this manuscript. A pre-publication pre-print of the same is available here: https://www.biorxiv.org/content/10.1101/2021.06.09.447812v1

# Recurrent erosion of COA1/MITRAC15 demonstrates gene dispensability in oxidative phosphorylation
 Sagar Sharad Shinde1, Sandhya Sharma1, Lokdeep Teekas1, Ashutosh Sharma1, Nagarjun Vijay1

1Computational Evolutionary Genomics Lab, Department of Biological Sciences, IISER Bhopal, Bhauri, Madhya Pradesh, India

*Correspondence: nagarjun@iiserb.ac.in

Data is organised into the following folders:

1.AlphaFold_model_comparision :The folder contains the input and results from files of the models compared from the AlphaFold website and the modeled structures from MODELLER (COA1). Its subdirectory "for_TIMM21" contains the input and result files of the models compared from the AlphaFold website and RCSB PDB website (TIM21).

2.CLANS_Results: The folder CLANS results contain human_COA1.fa, which is used as an input for HHblits, outputs of HHblits, and CLANS. The required supplementary files are provided inside the folder.

3.Figure2: The folder Figure2 has the input files for the main figure 2. In the main figure2, we checked the COA1 haplotypes in six different species. We made the specific folder for each species that contains sorted bam, COA1 gene sequence as a reference, index files of sorted bam, and the reference sequence.

4.Figure5 :The Figure5 folder contains the A to F folders with bam files for the main figure 5 from different bio-project IDs of woolly mammoth available raw read data from the short read archive. We checked reads support for COA1 gene exon sequences. The output files for the GC Vs. kmer plot are from 7 different project IDs of the woolly mammoth in the G folder. Required input files and script are provided in detail. 

5.Geneloss_timing:In this folder, three subfolders are available for inspecting the time of COA1 gene loss in few species of rodents, galliforms, and feliforms. The branch-free model is used in PAML with different combinations of labellings like pseudogene species, mixed species, and functional species with background species number variation. In combinations, folder name defines the labelling and unclear names readme provided inside those folders. All required files are provided in each folder/subfolders.   

6.HYPHYMP_Relax:input and Output files kept in this folder, running the RELAX program implemented in the HYPHY package.

7.PAML:Branch test and site test run using 4.9f version in different groups.

8.Tree_files_used_main_figure:tree files used for main figure.

9.gBGC:Inside this folder, calculated the GC* for the entire group as well as groups and in gBGC for groupwise. The input files, scripts, and results are provided inside respective folders.    

10.supplementary_figure_data:Inside this folder kept different supplementary data input and output. 

# Prerequisites:

PAML (4.9f)

blastn(2.2.31)

phastBias(1.6)

mapnh(1.3.0)

HYPHYMP (2.3.14)

DAMBE (7.3.2)

BWA(0.7.17-r1188)

Samtools (1.3)

jellyfish(2.2.8)

seqkit (0.10.1)

PRANK (v.150803)

IGV (2.8.13)

STAR (2.7.0d)

FigTree (1.4.2)

MODELLER(10.0)

PROTTER(1.0)

HHblits (3.3.0)

HHpred (https://toolkit.tuebingen.mpg.de/tools/hhpred) 

HeliQuest(https://heliquest.ipmc.cnrs.fr/)

PROTEUS2(2.0)

jvarkit

CodSeqGen ( https://doi.org/10.1016/j.ygeno.2019.02.002)

CLAN 

Gotree (https://github.com/evolbioinfo/gotree.git)


# R (4.1.0) 
# R packages
ape

phytools

ggplot2

ggrepel

cowplot

dplyr

ggplotify

grid

gridExtra

reshape2







