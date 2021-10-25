library(ape)
a<-read.tree("RAxML_bestTree__9primates__unrooted.tre")
b<-unroot(a)
b$edge.length<-NULL
b$node.label<-NULL
write.tree(b,"RAxML_bestTree__9primates__unrooted.tre.nwk")
