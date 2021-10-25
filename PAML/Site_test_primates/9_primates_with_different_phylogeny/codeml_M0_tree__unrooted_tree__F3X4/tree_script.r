library(ape)
a<-read.tree("codeml_M0_tree__unrooted_tree__F3X4.tre")
b<-unroot(a)
b$edge.length<-NULL
b$node.label<-NULL
write.tree(b,"codeml_M0_tree__unrooted_tree__F3X4.tre.nwk")
