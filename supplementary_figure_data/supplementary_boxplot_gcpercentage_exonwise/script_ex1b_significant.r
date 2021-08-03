jpeg("exon1b_significant.jpeg",height=1200,width=1200)
par(mai=c(2,1,1,1))
boxplot(b[,2:14],las=2,ylim=c(20,76),ylab="GC percentage",xlab="Group")
segments(2,20,3,20)
segments(2,22,5,22)
segments(2,24,7,24)
segments(2,26,9,26)
segments(2,28,10,28)
segments(3,30,4,30)
segments(3,32,5,32)
segments(3,60,6,60)
segments(3,62,10,62)
segments(5,64,6,64)
segments(5,66,7,66)
segments(6,68,7,68)
segments(6,70,8,70)
segments(6,72,9,72)
segments(6,74,10,74)

text(2.5,21,labels="p=0.00310")
text(3.5,23,labels="p=0.00051")
text(4,25,labels="p=0.00532")
text(6,29,labels="p=0.01427")
text(3.5,31,labels="p=0.03552")
text(4,33,labels="p=0.04865")
text(4.5,61,labels="p=0.01808")
text(5,63,labels="p=0.00048")
text(6.5,65,labels="p=0.03125")
text(7,69,labels="p=0.00017")
text(7,71,labels="p=0.01343")
text(4.5,27,labels="p=0.00790")
text(6,67,labels="p=0.01221")
text(8,75,labels="p=0.00391")
text(7.5,73,labels="p=0.03125")
dev.off()

