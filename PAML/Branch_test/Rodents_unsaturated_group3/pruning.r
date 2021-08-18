library(ape)
a<-read.tree("rodent_group3.nwk")
b<-read.table("Oryctolagus_cuniculus2.seq.fasta.list")
c<-as.character(b$V1)
d<-keep.tip(a,c)
write.tree(d,file="Oryctolagus_cuniculus2.seq.nwk")
