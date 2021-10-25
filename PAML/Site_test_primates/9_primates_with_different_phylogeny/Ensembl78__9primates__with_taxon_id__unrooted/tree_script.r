library(ape)
a<-read.tree("Ensembl78__9primates__with_taxon_id__unrooted.tre")
b<-unroot(a)
b$edge.length<-NULL
b$node.label<-NULL
write.tree(b,"Ensembl78__9primates__with_taxon_id__unrooted.tre.nwk")
