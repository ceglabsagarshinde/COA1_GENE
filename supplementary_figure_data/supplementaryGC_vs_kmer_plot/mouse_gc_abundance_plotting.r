jpeg("mouse_GC_abundance.jpeg",width=2400,height=800)
par(mai=c(1.5,1.5,0.5,0.5))
read.table(file="PRJEB35529.fa_jell_gc_counts",header=F)->M
M[order(M$V1), ]->N
plot(N$V1,N$V2/sum(N$V2),type="b",ylim=c(0,0.3),xlab="GC percent",ylab="Kmer abundance",cex.lab=4,cex.axis=2,lwd=5)
read.table(file="mouse_pacbio_ERR4824521_22_SRR11606870.fa_jell_gc_counts",header=F)->M
M[order(M$V1), ]->N
lines(N$V1,N$V2/sum(N$V2),type="b",ylim=c(0,0.3),xlab="GC percent",ylab="Kmer abundance",cex.lab=4,cex.axis=2,lwd=5,col="red")
legend("topright",legend=c(expression(paste(italic("Mus musculus"), " BGI Seq"), paste(italic("Mus musculus")," PacBio"))), col=c("black","red"),lwd=c(4,4),bty="n",cex=3,lty=c(1,1))
dev.off()
