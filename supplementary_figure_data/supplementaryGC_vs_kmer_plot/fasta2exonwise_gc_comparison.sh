## This script calculates exonwise GC percentage in different groups of species and do pairwise comparison of GC percentage distribution between groups.
## The input files are only_groups_COA1.fa, groupwise list of species, GC_content.pl and Rscript boxplot_pairwise_comparison.r.
## Furthermore the Rscript also generates all groupwise pairwise comparison pvalue which are saved in files with extension "pvalue".

echo -e "Group_name\tSpecies_name\tlength(exon1a)\tGC%(exon1a)\tlength(exon1b)\tGC%(exon1b)\tlength(exon2)\tGC%(exon2)\tlength(exon3)\tGC%(exon3)\tlength(exon4)\tGC%(exon4)" > gc_groupwise_exonwise_compiled.result
rm Final_result.exonwise
echo -e 'file=$1' > transpose.sh
echo -e 'ncol=`awk '"'{ print NF }'"' $file|sort -u|sort -nr|head -1`' >> transpose.sh
echo -e 'for col in `seq 1 1 $ncol`' >> transpose.sh
echo "do" >> transpose.sh
echo "awk '{print \$c}' c=\$col \$file|tr '\n' '\t'|awk '{print}'" >> transpose.sh
echo "done" >> transpose.sh
chmod a+x transpose.sh

sed -e 's/ //g' -e 's/\t//g' -e '/^>/s/$/@/g' -e '/^$/d' -e 's/$/#/g' only_groups_COA1.fa|tr -d '\n' |sed 's/>/\n>/g' |sed '1d' > all_seq.fa
for sp in `grep ">" only_groups_COA1.fa|sed 's/>//g'`
do
grep "$sp" all_seq.fa > "$sp".txt
sed -e 's/@#/\n/g'  -e 's/#/\n/g' "$sp".txt|grep "^[A-Z]" > first.file
inti=1
while read j
do
echo ">"$sp"_exon"$inti >> "$sp".fasta
echo $j >> "$sp".fasta
inti=`echo $inti|awk '{print $1 + 1}'`
done < first.file
rm first.file "$sp".txt
perl GC_content.pl -fasta "$sp".fasta -window 100 -step 10 > gc_percent.txt
grep "exon" gc_percent.txt|grep -v "Working"|sort -k1|awk 'NF==4 {print $2,$3}' OFS='\n' > to_transpose.txt
transposed_values=`bash transpose.sh to_transpose.txt`
echo $sp $transposed_values |sed 's/ /\t/g' >> Final_result.exonwise
done
rm *.txt *.GC_* all_seq.fa *.fasta

for grps in `ls *.1`
do
for sp in `cat $grps`
do
j=`grep "$sp" Final_result.exonwise`
grp=`echo ${grps%.1}`
echo $grp $j|sed 's/ /\t/g' >> gc_groupwise_exonwise_compiled.result
done
done

## gc_groupwise_exonwise_compiled.result was modified manually to shift the exon1a before canonical exon 1 in primates and exon 3 of Caniformia which actually is exon 4 (except Suricata suricatta, which contain both exon3 and exon4). Please refer to supplementary text and discussion for further details.
## The modified table was downloaded from the supplementary table named "boxplot_data".
chmod a+x boxplot_pairwise_comparison.r
Rscript boxplot_pairwise_comparison.r
