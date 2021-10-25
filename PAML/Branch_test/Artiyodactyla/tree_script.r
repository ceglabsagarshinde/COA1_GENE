library(ape)
a<-read.tree("Artiyodactyla.nwk")
b<-unroot(a)
write.tree(b,"Artiyodactyla.nwk.tree")
