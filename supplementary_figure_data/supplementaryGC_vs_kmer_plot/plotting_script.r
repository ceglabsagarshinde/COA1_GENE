M<-read.table("chicken.SRR12103809_SRR1744081_SRR3041423_SRR3954707.fa_jell_gc_counts",header=F)
N<-read.table("mouse_pacbio_ERR4824521_22_SRR11606870.fa_jell_gc_counts",header=F)
O<-read.table("mouse_bgi.PRJEB35529.fa_jell_gc_counts",header=F)
P<-read.table("tiger_SRR836311_15.fa_jell_gc_counts",header=F)
Q<-read.table("human.SRR12461183.fa_jell_gc_counts",header=F)
R<-read.table("koala.ERR1875324_ERR1875622.fa_jell_gc_counts",header=F)
S<-read.table("all_gc_input.txt")
a1<-read.table("platypus_SRR6749829_929.fa_jell_gc_counts",header=F)
a1[order(a1$V1), ]->a2
M[order(M$V1), ]->M1
N[order(N$V1), ]->N1
O[order(O$V1), ]->O1
P[order(P$V1), ]->P1
Q[order(Q$V1), ]->Q1
R[order(R$V1), ]->R1

jpeg("1final.jpeg",width=2100,height=1300)
par(mfrow=c(2,1),mai=c(3,3,0.5,0.5),mgp=c(7,0.5,0.2))
plot(M1$V1,M1$V2/sum(M1$V2),type="l",ylim=c(0,0.3),xlab="GC percentage",ylab="k-mer abundance",cex.lab=4,cex.axis=2,lwd=5,lty=1,col="black")
lines(N1$V1,N1$V2/sum(N1$V2),lty=1,ylim=c(0,0.3),xlab="GC percent",ylab="Kmer abundance",cex.lab=4,cex.axis=2,lwd=5,col="red")
lines(O1$V1,O1$V2/sum(O1$V2),lty=2,ylim=c(0,0.3),xlab="GC percent",ylab="Kmer abundance",cex.lab=4,cex.axis=2,lwd=5,col="red")
lines(P1$V1,P1$V2/sum(P1$V2),lty=1,ylim=c(0,0.3),xlab="GC percent",ylab="Kmer abundance",cex.lab=4,cex.axis=2,lwd=5,col="orange")
lines(Q1$V1,Q1$V2/sum(Q1$V2),lty=1,ylim=c(0,0.3),xlab="GC percent",ylab="Kmer abundance",cex.lab=4,cex.axis=2,lwd=5,col="brown")
lines(R1$V1,R1$V2/sum(R1$V2),lty=1,ylim=c(0,0.3),xlab="GC percent",ylab="Kmer abundance",cex.lab=4,cex.axis=2,lwd=5,col="green")
lines(a2$V1,a2$V2/sum(a2$V2),lty=1,ylim=c(0,0.3),xlab="GC percent",ylab="Kmer abundance",cex.lab=4,cex.axis=2,lwd=5,col="dark blue")
legend("topright",legend=c(expression(paste(italic("Gallus gallus")), paste(italic("Mus musculus")," PacBio"),paste(italic("Mus musculus"), " BGI Seq"), paste(italic("Panthera tigris")),paste(italic("Homo sapiens")), paste(italic("Phascolarctos cinereus")," PacBio"),paste(italic("Ornithorhynchus anatinus")," PacBio"))), col=c("black","red","red","orange","brown","green","dark blue"),lwd=c(4,4,4,4,4,4,4),bty="n",cex=2,lty=c(1,1,2,1,1,1,1))
boxplot(S$V1~S$V2,horizontal=T,col=c("orange","green","blue","pink"),ylab=c(""),xlab=c("GC percentage"),cex.axis=2,cex.lab=4,las=1,ylim=c(0,100))
dev.off()
