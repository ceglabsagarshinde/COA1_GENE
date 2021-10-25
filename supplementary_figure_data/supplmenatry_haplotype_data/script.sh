##Made a bam file using blastn output 

#!/bin/bash
##Downloaded the genomic raw-reads from European Nucleotide Archive
## for database creation and blastn
zcat *.gz|sed -n '1~4s/^@/>/p;2~4p' > $i
j="species_name"
makeblastdb -in $i -out $i -dbtype nucl
##Ran blastn using query sequence from NCBI  
##query sequence 
q="query_sequence"
blastn -task blastn -evalue 0.01 -db $i -out blastn_"$j"_DNA_"$i"_COA1."$q".sam -num_threads 2 -outfmt 17 SQ  -query $q

## sam files were converted to sorted bamfiles using samtools.
for i in *sam;
do;
samtools view -bhS $i > $i.bam;
samtools sort $i.bam -o $i.sorted.bam;
samtools index $i.sorted.bam;
done

##The sorted bam files were visualized in igv and checked for polymorphic site between two reads. The read groups were added based on the changes in the polymorphic sites. 
##For read group addition, we used jvarkit
java -jar biostar214299.jar -p positions.tsv input.bam

##For each species, the respective bam file, gene reference file and it's associated index file are kept in the directory with species name.
