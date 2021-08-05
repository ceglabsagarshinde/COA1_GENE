## the input is the database fasta file. The *_counts output file of the last step is used for generating the plot.
i=$1
jellyfish count -m 21 -s 1000M -t 10 -C $i -o "$i"_jell
jellyfish dump "$i"_jell > "$i"_jell_counts_dumps.fa
seqkit fx2tab --name --gc "$i"_jell_counts_dumps.fa > "$i"_jell_gc_counts.txt
paste "$i"_jell_counts_dumps.fa "$i"_jell_gc_counts.txt|awk '{printf "%.0f %.2f\n", $2,$3}'|awk '{a[$2] += $1} END{for (i in a) print i, a[i]}' > "$i"_jell_gc_counts

## for calculating the GC percent. We ran the calculated the GC content along the exons of the fasts file in 100 sliding window with step size of 10 base pairs using the script downloaded from https://github.com/DamienFr/GC_content_in_sliding_window.git
perl GC_content.pl -fasta inputfasta.file -window 100 -step 10

sed 's/^\t//g' mammoth_coa1_gc_content.txt |grep "^EXON"|sort |awk '{print $1"\t"$3}' > table1coa1.txt
sed 's/^\t//g' mammoth_timm21_gc_content.txt |grep "^exon"|sort |awk '{print $1"\t"$3}' > table1timm21.txt


## plotting the figure
Rscript script.r
