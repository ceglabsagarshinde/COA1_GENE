# COA1
COA1 is a four exonic gene that regulates cytochrome c oxidase assembly. Other names include Cytochrome C Oxidase Assembly Factor 1 Homolog, C7orf44, and MITRAC15 (mitochondrial translation regulation assembly intermediate of cytochrome c oxidase complex) complex.
The code and data provided in this project are part of the below manuscript. The scripts and data are organized to ensure the integrity, credibility, and replicability of the results reported. However, the goal of this repository is not to release a fully automated pipeline and is beyond the scope of this manuscript. A pre-publication pre-print of the same is available here: https://www.biorxiv.org/content/10.1101/2021.06.09.447812v1

# Recurrent erosion of COA1/MITRAC15 demonstrates gene dispensability in oxidative phosphorylation
 Sagar Sharad Shinde1, Sandhya Sharma1, Lokdeep Teekas1, Ashutosh Sharma1, Nagarjun Vijay1

1Computational Evolutionary Genomics Lab, Department of Biological Sciences, IISER Bhopal, Bhauri, Madhya Pradesh, India

*Correspondence: nagarjun@iiserb.ac.in

Data is organised into the following folders:

1.AlphaFold_model_comparision : The folder contains the input and results from files of the models compared from the AlphaFold website and the modeled structures from MODELLER (COA1). Its subdirectory "for_TIMM21" contains the input and result files of the models compared from the AlphaFold website and RCSB PDB website (TIM21).

2.Figure1: The folder Figure1 contain human_COA1.fa, which is used as an input for HHblits, outputs of HHblits, and CLANS. The required supplementary files are provided inside the folder.

3.Geneloss_timing: In this folder, three subfolders are available for inspecting the time of COA1 gene loss in a few species of rodents, galliforms, and feliforms. The branch-free model is used in PAML with different combinations of labellings like pseudogene species, mixed species, and functional species with background species number variation. In combinations, folder name defines the labelling and unclear names readme provided inside those folders. All required files are provided in each folder/subfolders.

4.HYPHYMP_Relax: input and Output files kept in this folder, running the RELAX program implemented in the HYPHY package.

5.PAML: Branch test and site test run using 4.9f version in different groups.

6.Tree_files_used_main_figure:tree files used for main figure.

7.gBGC: Inside this folder, calculated the GC* for the entire group and groups and in gBGC for groupwise. The input files, scripts, and results are provided inside respective folders.

8.supplementary_figure_data: Inside this folder kept different supplementary data input and output.

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







