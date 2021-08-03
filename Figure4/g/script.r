jpeg("GC_abundance.jpeg",width=2400,height=800)
par(mai=c(1.5,1.5,0.5,0.5))
read.table(file="PRJEB7929_ERR852028_ERR855944.fa_jell_gc_counts",header=F)->M
M[order(M$V1), ]->N
plot(N$V1,N$V2/sum(N$V2),type="b",ylim=c(0,0.3),xlab="GC percent",ylab="Kmer abundance",cex.lab=4,cex.axis=2,lwd=5)

read.table(file="PRJDB4697_DRR058709_14.fa_jell_gc_counts",header=F)->M
M[order(M$V1), ]->N
points(N$V1,N$V2/sum(N$V2),type="b",col="blue",lwd=5)

read.table(file="PRJNA247496_SRR1945357_58_59_80.fa_jell_gc_counts2",header=F)->M
M[order(M$V1), ]->N
points(N$V1,N$V2/sum(N$V2),type="b",col="green",lwd=5)

read.table(file="PRJEB29510_ERR2868538_39_41.fa_jell_gc_counts2",header=F)->M
M[order(M$V1), ]->N
points(N$V1,N$V2/sum(N$V2),type="b",col="brown",lwd=5)

read.table(file="PRJNA397140_SRR5909293_SRR5922898_SRR5922898.fa_jell_gc_counts2",header=F)->M
M[order(M$V1), ]->N
points(N$V1,N$V2/sum(N$V2),type="b",col="yellow",lwd=5)

read.table(file="PRJEB42269_SRR5032103_07_18_22_30_34.fa_jell_gc_counts2",header=F)->M
M[order(M$V1), ]->N
points(N$V1,N$V2/sum(N$V2),type="b",col="orange",lwd=5)

abline(v=41.18,col="red",lty=1,lwd=5)
abline(v=47.65,col="red",lty=1,lwd=5)
abline(v=54.55,col="red",lty=1,lwd=5)
abline(v=48.48,col="red",lty=1,lwd=5)
arrows(41.18,0.27,60,0.27,code=2,length=0.2,col="blue",lwd=5)
arrows(47.65,0.26,60,0.26,code=2,length=0.2,col="blue",lwd=5)
arrows(54.55,0.25,60,0.25,code=2,length=0.2,col="blue",lwd=5)
arrows(48.48,0.24,60,0.24,code=2,length=0.2,col="blue",lwd=5)
text(63,0.27,labels="Exon 1",cex=2,col="dark green")
text(63,0.26,labels="Exon 2",cex=2,col="dark green")
text(63,0.25,labels="Exon 3",cex=2,col="dark green")
text(63,0.24,labels="Exon 4",cex=2,col="dark green")


legend("topright",legend=c("PRJEB7929","PRJDB4697","PRJNA247496","PRJEB29510","PRJNA397140","PRJEB42269"),col=c("black","blue","green","brown","yellow","orange"),lwd=c(4,4,4,4,4,4),bty="n",cex=3,lty=c(1,1,1,1,1,1))
dev.off()
