library(ape)
a<-read.tree("Caniformia.nwk")
b<-unroot(a)
write.tree(b,"Caniformia.nwk.tree")
