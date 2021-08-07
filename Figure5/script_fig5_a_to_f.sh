## Made a bam file using blastn output 

#!/bin/bash
## Downloaded the genomic raw-reads from European Nucleotide Archive
## For database creation and blastn
zcat *.gz|sed -n '1~4s/^@/>/p;2~4p' > $i
j="species_name"
makeblastdb -in $i -out $i -dbtype nucl
## Ran blastn using query sequence from NCBI  
## Query sequence 
q="query_sequence"
blastn -task blastn -evalue 0.01 -db $i -out blastn_"$j"_DNA_"$i"_COA1."$q".sam -num_threads 2 -outfmt 17 SQ  -query $q

## The sam files were converted into sorted bamfiles using samtools.
for i in *sam;
do;
samtools view -bhS $i > $i.bam;
samtools sort $i.bam -o $i.sorted.bam;
samtools index $i.sorted.bam;
done

## Sorted bam files were visualized in igv. The generated images are represented in Figure5 A-F 
## Directories with name A-F contains bam files associated with Mammoth's COA1 gene sequence generated from different BioSample IDs from NCBI/ENA. The associated figures are Figure5 A-F
