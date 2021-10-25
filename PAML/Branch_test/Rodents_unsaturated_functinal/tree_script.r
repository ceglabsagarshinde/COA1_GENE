library(ape)
a<-read.tree("Rodents_functional.nwk")
b<-unroot(a)
write.tree(b,"Rodents_functional.nwk.tree")
