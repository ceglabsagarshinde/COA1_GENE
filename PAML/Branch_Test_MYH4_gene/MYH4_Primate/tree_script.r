library(ape)
a<-read.tree("Primates_MYH4.nwk")
b<-unroot(a)
b$node.label<-NULL
write.tree(b,"Primates_MYH4.nwk.tree")
