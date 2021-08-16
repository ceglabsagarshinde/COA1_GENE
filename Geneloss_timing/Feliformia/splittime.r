library(ape)
library(reshape2)
a<-read.tree("feliformia.nwk")
cophenetic(a)->v
subset(melt(v), value!=0)->v1
v1$value= round(v1$value/2,digit=2)
write.table(v1,file="pairwise.txt",quote=F,sep="\t",row.names=F,col.names=F)
