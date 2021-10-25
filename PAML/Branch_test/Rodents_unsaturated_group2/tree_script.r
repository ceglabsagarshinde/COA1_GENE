library(ape)
a<-read.tree("rodent_group2.nwk")
b<-unroot(a)
write.tree(b,"rodent_group2.nwk.tree")
