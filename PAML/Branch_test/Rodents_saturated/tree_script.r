library(ape)
a<-read.tree("rodents.nwk")
b<-unroot(a)
write.tree(b,"rodents.nwk.tree")
