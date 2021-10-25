library(ape)
a<-read.tree("perissodactyla.nwk")
b<-unroot(a)
write.tree(b,"perissodactyla.nwk.tree")
