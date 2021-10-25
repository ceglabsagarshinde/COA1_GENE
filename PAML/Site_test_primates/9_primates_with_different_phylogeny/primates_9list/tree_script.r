library(ape)
a<-read.tree("primates_9list.tre")
b<-unroot(a)
b$edge.length<-NULL
b$node.label<-NULL
write.tree(b,"primates_9list.tre.nwk")
