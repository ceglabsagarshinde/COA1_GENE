library(ape)
a<-read.tree("Perelman_et_al__9primates__unrooted.tre")
b<-unroot(a)
b$edge.length<-NULL
b$node.label<-NULL
write.tree(b,"Perelman_et_al__9primates__unrooted.tre.nwk")
