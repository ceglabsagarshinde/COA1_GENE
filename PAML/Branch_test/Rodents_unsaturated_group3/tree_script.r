library(ape)
a<-read.tree("rodent_group3.nwk")
b<-unroot(a)
write.tree(b,"rodent_group3.nwk.tree")
