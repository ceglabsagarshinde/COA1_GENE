jpeg("exon1a_significant.jpeg",height=1200,width=1200)
par(mai=c(3,3,1.5,1.2),mgp=c(12,0.7,0.2))
boxplot(b[,2:14],las=2,ylim=c(20,76),ylab="GC percentage",xlab="Group",main="Exon 1a",cex.main=5,cex.lab=3,cex.axis=2)

segments(1,20,2,20)
segments(1,22,3,22)
segments(1,24,4,24)
segments(1,26,5,26)
segments(1,28,6,28)
segments(1,30,7,30)
segments(1,32,9,32)
segments(2,60,3,60)
segments(2,62,5,62)
segments(2,64,7,64)
segments(2,66,9,66)
segments(2,68,10,68)
segments(3,70,4,70)
segments(3,72,5,72)
segments(1,74,6,74)
segments(1,76,10,76)
segments(5,78,6,78)
segments(5,80,7,80)
segments(6,82,7,82)
segments(6,84,8,84)
segments(6,86,9,86)
segments(6,88,10,88)
text(1.5,21,labels="p=2.9e-05",cex=1.2)
text(2,23,labels="p=1.2e-03",cex=1.2)
text(2.5,25,labels="p=7.9e-05",cex=1.2)
text(3,27,labels="p=2.4e-02",cex=1.2)
text(3.5,29,labels="p=9.4e-05",cex=1.2)
text(4,31,labels="p=1.6e-03",cex=1.2)
text(4.5,33,labels="p=3.9e-03",cex=1.2)
text(2.5,61,labels="p=7.0e-03",cex=1.2)
text(3.5,63,labels="p=6.3e-04",cex=1.2)
text(4,65,labels="p=5.3e-03",cex=1.2)
text(6,67,labels="p=1.4e-02",cex=1.2)
text(6.5,69,labels="p=3.6e-02",cex=1.2)
text(3.5,71,labels="p=1.7e-02",cex=1.2)
text(3.5,75,labels="p=1.3e-02",cex=1.2)
text(5.5,77,labels="p=4.8e-04",cex=1.2)
text(5.5,79,labels="p=3.1e-02",cex=1.2)
text(6,81,labels="p=1.7e-04",cex=1.2)
text(6.5,83,labels="p=1.3e-02",cex=1.2)
text(7,85,labels="p=7.9e-03",cex=1.2)
text(7.5,87,labels="p=1.2e-02",cex=1.2)
text(8,89,labels="p=3.9e-03",cex=1.2)
text(4,73,labels="p=3.1e-02",cex=1.2)
dev.off()
