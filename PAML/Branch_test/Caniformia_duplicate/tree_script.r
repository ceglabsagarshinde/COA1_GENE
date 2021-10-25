library(ape)
a<-read.tree("Caniformia_duplicate.nwk")
b<-unroot(a)
write.tree(b,"Caniformia_duplicate.nwk.tree")
