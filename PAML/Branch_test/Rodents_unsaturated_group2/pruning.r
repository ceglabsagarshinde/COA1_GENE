library(ape)
a<-read.tree("rodent_group2.nwk")
b<-read.table("Urocitellus_parryii2.seq.fasta.list")
c<-as.character(b$V1)
d<-keep.tip(a,c)
write.tree(d,file="Urocitellus_parryii2.seq.nwk")
