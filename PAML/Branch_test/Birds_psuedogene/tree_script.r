library(ape)
a<-read.tree("birds.nwk")
b<-unroot(a)
write.tree(b,"birds.nwk.tree")
