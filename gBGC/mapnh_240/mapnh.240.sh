#!/bin/bash
##calculating the weak to strong(AT>GC) and strong to weak (GC>AT) conversion using mapnh.
for i in mapnh_240
do
mapnh map.type=GC output.counts.tree.prefix=all_gc.prefix2 input.sequence.file=$i.aln input.tree.file=$i.nwk test.branch=1 test.global=1 model=K80
cat mapping_counts_per_type_AT-\>CG.dnd |tr "," "\n" |sed 's/(//g' |sed 's/).*//g' |sed 's/:/\t/g' > at2gc.1
cat mapping_counts_per_type_CG-\>AT.dnd |tr "," "\n" |sed 's/(//g' |sed 's/).*//g' |sed 's/:/\t/g' > gc2at.1
paste gc2at.1 at2gc.1 > $i.ratio.2
sort -k1,1 $i.ratio.2 > $i.ratio.2.final
done

Rscript contMap.R
