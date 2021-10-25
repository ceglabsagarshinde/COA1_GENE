library(ape)
a<-read.tree("Amphibian_Reptiles.nwk")
b<-unroot(a)
write.tree(b,"Amphibian_Reptiles.nwk.tree")
