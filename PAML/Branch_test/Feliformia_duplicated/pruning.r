library(ape)
a<-read.tree("Feliformia.nwk")
b<-read.table("Suricata_suricatta2.seq.fasta.list")
c<-as.character(b$V1)
d<-keep.tip(a,c)
write.tree(d,file="Suricata_suricatta2.seq.nwk")
