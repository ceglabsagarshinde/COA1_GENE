library(ape)
a<-read.tree("Feliformia.nwk")
b<-unroot(a)
write.tree(b,"Feliformia.nwk.tree")
