library(ape)
a<-read.tree("Feliformia_pseudogene.nwk")
b<-read.table("list.txt")
c<-as.character(b$V1)
d<-keep.tip(a,c)
write.tree(d,file="Acinonyx_jubatus.nwk")
