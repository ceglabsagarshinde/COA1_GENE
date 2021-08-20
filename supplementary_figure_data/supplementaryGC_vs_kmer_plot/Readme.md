# GC vs Kmer plot
This folder contains the input fasta file containing COA1 sequence of 236 species, the groupwise species list with extension *.1 and the executable files required to generated the boxplot after calculating the exonwise GC content.
The script used is fasta2exonwise_gc_comparison.sh. This script also requires an r script "boxplot_pairwise_comparison.r" for generating plots.
gc_groupwise_exonwise_compiled.result was modified manually to shift the exon1a before canonical exon 1 in primates and exon 3 of Caniformia which actually is exon 4 (except Suricata suricatta, which contain both exon3 and exon4). Please refer to supplementary text and discussion for further details.
The modified table was downloaded from the supplementary table named "boxplot_data".
