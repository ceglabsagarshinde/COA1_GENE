awk '{print $1,$4,$10,$12}' OFS='\t' background_species_effect/outfilecompile|sed '1d' > outfilecompile_combined
awk '{print $1,$3,$8,$10}' OFS='\t' Feliformia/outfilecompile|sed '1d' >> outfilecompile_combined
awk '{print $2,$4,$9,$11}' OFS='\t' Galliformes/outfilecompile|sed '1d' >> outfilecompile_combined
awk '{print $2,$4,$9,$11}' OFS='\t' Rodents_saturated/outfilecompile|sed '1d' >> outfilecompile_combined
awk '{print $2,$4,$9,$11}' OFS='\t' Rodents_unsaturated/outfilecompile|sed '1d' >> outfilecompile_combined
