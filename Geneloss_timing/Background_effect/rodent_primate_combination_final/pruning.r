library(ape)
a<-read.tree("rodent_primate_combination.nwk")
b<-read.table("partlist")
c<-as.character(b$V1)
d<-keep.tip(a,c)
write.tree(d,file="part.nwk")