library(ape)
a<-read.tree("rodent_group3.nwk")
b<-read.table("list.txt")
c<-as.character(b$V1)
d<-keep.tip(a,c)
write.tree(d,file="Oryctolagus_cuniculus.nwk")