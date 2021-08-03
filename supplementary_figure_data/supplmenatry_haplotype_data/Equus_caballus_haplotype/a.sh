zcat *.gz|sed -n '1~4s/^@/>/p;2~4p' > SRR12847170.fa
i="SRR12847170.fa"
makeblastdb -in $i -out $i -dbtype nucl

i="SRR12847170.fa"
q="Equus_caballus_COA1.fa"
blastn -task blastn -evalue 0.01 -db $i -out blastn_Equus_caballus_DNA_"$i"_coa1_dog_cp2.hits.out -num_threads 2 -outfmt 1 -query $q

i="SRR12847170.fa"
q="Equus_caballus_COA1.fa"
blastn -task blastn -evalue 0.01 -db $i -out blastn_Equus_caballus_DNA_"$i"_coa1_dog_cp2.hits.sam -num_threads 2 -outfmt '17 SQ' -query $q


rm *gz
