library(ape)
a<-read.tree("primates_27list.nwk")
b<-unroot(a)
b$node.label<-NULL
write.tree(b,"primates_27list.nwk.tree")
