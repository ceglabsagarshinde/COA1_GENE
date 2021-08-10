# COA1
COA1 is a four exonic gene that regulates cytochrome c oxidase assembly. Other names include Cytochrome C Oxidase Assembly Factor 1 Homolog, C7orf44 and MITRAC15 (mitochondrial translation regulation assembly intermediate of cytochrome c oxidase complex) complex.

The code and data provided in this project are part of the below manuscript. The scripts and data are organised to ensure the integrity, credibility and replicability of the results reported. However, the goal of this repository is not to release a fully-automate pipeline and is beyond the scope of this manuscript. A pre-publication pre-print of the same is available here: https://www.biorxiv.org/content/10.1101/2021.06.09.447812v1

# Recurrent erosion of COA1/MITRAC15 demonstrates gene dispensability in oxidative phosphorylation
 Sagar Sharad Shinde1, Sandhya Sharma1, Lokdeep Teekas1, Ashutosh Sharma1, Nagarjun Vijay1

1Computational Evolutionary Genomics Lab, Department of Biological Sciences, IISER Bhopal, Bhauri, Madhya Pradesh, India

*Correspondence: nagarjun@iiserb.ac.in

Data is organised into the following folders:
1.AlphaFold_model_comparision :

2.CLANS_Results: The folder CLANS results contains human_COA1.fa, which is used as a input for HHblits, outputs of HHblits and CLANS. The required supplimentary files are provided inside the folder.

3.Figure2: The folder Figure2 have the input files for the main figure 2. In the main figure2 we checked the COA1 haplotypes in six different species. For each species we made the specific folder which contains sorted bam, COA1 gene sequence as reference, index files of sorted bam and reference sequence.

4.Figure5 :The Figure5 folder contains the A to F folders with bam files for the main figure 5 from different bio-project IDs of woolly mammoth available raw read data from the short read archive. We checked reads support for COA1 gene exon sequences. The output files for the GC Vs. kmer plot are from 7 different project IDs of the woolly mammoth in the G folder. Required input files and script are provided in detail. 

5.Geneloss_timing:In this folder, three subfolders are available for inspecting the time of COA1 gene loss in few species of rodents, galliforms, and feliforms. The branch-free model is used in PAML with different combinations of labelings like pseudogene species, mixed species, and functional species with background species number variation. In combinations, folder name defines the labeling and unclear names readme provided inside those folders. All required files are provided in each folder/subfolders.   

6.HYPHYMP_Relax:

7.PAML:

8.Tree_files_used_main_figure:

9.gBGC:

10.supplementary_figure_data:

Prerequisites:
PAML (4.9f)
blastn(2.2.31)
phastBias(1.6)
mapNh(1.3.0)
HYPHYMP (2.3.14)
DAMBE (7.3.2)
BWA(0.7.17-r1188)
Samtools (1.3)


