
g1<-read.table("table1coa1.txt")
g2<-read.table("table1timm21.txt")

jpeg("GC_abundance.jpeg",width=2400,height=800)
par(mai=c(1.5,1.5,0.5,0.5))
read.table(file="PRJEB7929_ERR852028_ERR855944.fa_jell_gc_counts",header=F)->M
M[order(M$V1), ]->N
plot(N$V1,N$V2/sum(N$V2),type="b",ylim=c(0,0.3),xlab="GC percent",ylab="k-mer abundance",cex.lab=4,cex.axis=2,lwd=5)

read.table(file="PRJDB4697_DRR058709_14.fa_jell_gc_counts",header=F)->M
M[order(M$V1), ]->N
points(N$V1,N$V2/sum(N$V2),type="b",col="blue",lwd=5)

read.table(file="PRJNA247496_SRR1945357_58_59_80.fa_jell_gc_counts",header=F)->M
M[order(M$V1), ]->N
points(N$V1,N$V2/sum(N$V2),type="b",col="green",lwd=5)

read.table(file="PRJEB29510_ERR2868538_39_41.fa_jell_gc_counts",header=F)->M
M[order(M$V1), ]->N
points(N$V1,N$V2/sum(N$V2),type="b",col="brown",lwd=5)

read.table(file="PRJNA397140_SRR5909293_SRR5922898_SRR5922898.fa_jell_gc_counts",header=F)->M
M[order(M$V1), ]->N
points(N$V1,N$V2/sum(N$V2),type="b",col="yellow",lwd=5)

read.table(file="PRJEB42269_SRR5032103_07_18_22_30_34.fa_jell_gc_counts",header=F)->M
M[order(M$V1), ]->N
points(N$V1,N$V2/sum(N$V2),type="b",col="deepskyblue",lwd=5)

read.table(file="SRR2017948_78.fa_jell_gc_counts",header=F)->M
M[order(M$V1), ]->N
points(N$V1,N$V2/sum(N$V2),type="b",col="purple",lwd=5)

abline(v=g1[1,2],col="red",lty=1,lwd=5)
abline(v=g1[2,2],col="red",lty=1,lwd=5)
abline(v=g1[3,2],col="red",lty=1,lwd=5)
abline(v=g1[4,2],col="red",lty=1,lwd=5)
arrows(g1[1,2],0.27,60,0.27,code=1,length=0.2,col="red",lwd=5)
arrows(g1[2,2],0.25,60,0.25,code=1,length=0.2,col="red",lwd=5)
arrows(g1[3,2],0.23,60,0.23,code=1,length=0.2,col="red",lwd=5)
arrows(g1[4,2],0.21,60,0.21,code=1,length=0.2,col="red",lwd=5)
text(64,0.27,labels="Exon 1 {COA1}",cex=2,col="dark green")
text(64,0.25,labels="Exon 2 {COA1}",cex=2,col="dark green")
text(64,0.23,labels="Exon 3 {COA1}",cex=2,col="dark green")
text(64,0.21,labels="Exon 4 {COA1}",cex=2,col="dark green")

abline(v=g2[1,2],col="orange",lty=2,lwd=5)
abline(v=g2[2,2],col="orange",lty=2,lwd=5)
abline(v=g2[3,2],col="orange",lty=2,lwd=5)
abline(v=g2[4,2],col="orange",lty=2,lwd=5)
abline(v=g2[5,2],col="orange",lty=2,lwd=5)
abline(v=g2[6,2],col="orange",lty=2,lwd=5)
arrows(30,0.28,g2[1,2],0.28,code=2,length=0.2,col="orange",lwd=5)
arrows(30,0.26,g2[2,2],0.26,code=2,length=0.2,col="orange",lwd=5)
arrows(30,0.24,g2[3,2],0.24,code=2,length=0.2,col="orange",lwd=5)
arrows(30,0.22,g2[4,2],0.22,code=2,length=0.2,col="orange",lwd=5)
arrows(30,0.20,g2[5,2],0.20,code=2,length=0.2,col="orange",lwd=5)
arrows(30,0.18,g2[6,2],0.18,code=2,length=0.2,col="orange",lwd=5)
text(24,0.28,labels="Exon 1 {TIMM21}",cex=2,col="dark green")
text(24,0.26,labels="Exon 2 {TIMM21}",cex=2,col="dark green")
text(24,0.24,labels="Exon 3 {TIMM21}",cex=2,col="dark green")
text(24,0.22,labels="Exon 4 {TIMM21}",cex=2,col="dark green")
text(24,0.20,labels="Exon 5 {TIMM21}",cex=2,col="dark green")
text(24,0.18,labels="Exon 6 {TIMM21}",cex=2,col="dark green")

legend("topright",legend=c("PRJEB7929","PRJDB4697","PRJNA247496","PRJEB29510","PRJNA397140","PRJEB42269","PRJNA281811"),col=c("black","blue","green","brown","yellow","deepskyblue","purple"),lwd=c(4,4,4,4,4,4),bty="n",cex=3,lty=c(1,1,1,1,1,1))
dev.off()

