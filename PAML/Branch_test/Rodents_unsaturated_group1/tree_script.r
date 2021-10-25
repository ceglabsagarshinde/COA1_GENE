library(ape)
a<-read.tree("rodent_group1.nwk")
b<-unroot(a)
write.tree(b,"rodent_group1.nwk.tree")
