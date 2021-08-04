#!/bin/bash
#for m in `ls *.fa`
#do
#Run multiple MSA programs through guidance with 100 bootstraps
#perl /home/nagarjun/guidance.v2.02/www/Guidance/guidance.pl --program GUIDANCE --seqFile "$m" --msaProgram PRANK --seqType codon --outDir "$m".100_PRANK --genCode 1 --bootstraps 100 --proc_num 4
#sort MSA files before comparing
##Use https://github.com/shenwei356/seqkit
#cp "$m".100_PRANK/MSA.PRANK.aln.With_Names .
#mv MSA.PRANK.aln.With_Names COA1_241.aln
#done
##calculating the weak to strong(AT>GC) and strong to weak (GC>AT) conversion using mapnh.
for i in *.aln
do
j=`echo $i|cut -d. -f1`
mapnh map.type=GC output.counts.tree.prefix=all_gc.prefix2 input.sequence.file=$i input.tree.file=240.nwk test.branch=1 test.global=1 model=K80
cat mapping_counts_per_type_AT-\>CG.dnd |tr "," "\n" |sed 's/(//g' |sed 's/).*//g' |sed 's/:/\t/g' > at2gc.1
cat mapping_counts_per_type_CG-\>AT.dnd |tr "," "\n" |sed 's/(//g' |sed 's/).*//g' |sed 's/:/\t/g' > gc2at.1
paste gc2at.1 at2gc.1 > $i.ratio.2
sort -k1,1 $i.ratio.2 > $i.ratio.2.final
done
