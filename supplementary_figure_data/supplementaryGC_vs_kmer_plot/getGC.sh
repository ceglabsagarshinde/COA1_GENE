## the input is the database fasta file. The *_counts output file of the last step is used for generating the plot.
i=$1
jellyfish count -m 21 -s 1000M -t 10 -C $i -o "$i"_jell
jellyfish dump "$i"_jell > "$i"_jell_counts_dumps.fa
seqkit fx2tab --name --gc "$i"_jell_counts_dumps.fa > "$i"_jell_gc_counts.txt
paste "$i"_jell_counts_dumps.fa "$i"_jell_gc_counts.txt|awk '{printf "%.0f %.2f\n", $2,$3}'|awk '{a[$2] += $1} END{for (i in a) print i, a[i]}' > "$i"_jell_gc_counts
