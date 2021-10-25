library(ape)
a<-read.tree("Afrotheria.nwk")
b<-unroot(a)
write.tree(b,"Afrotheria.nwk.tree")
