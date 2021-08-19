d=read.table(file="boxplot_data",header=F,fill=T,na.strings = "NA",sep='\t')
a<-data.frame(d[,c(1,4,6,8,10,12)])
species<-as.character(unique(a$V1))
len<-length(species)

for ( exon in seq(1,4,1)){
maxquan=0
P<- data.frame(id = character(0), p.value = numeric(0))
for ( i in seq(1,len,1)){
for (j in seq(2,len,1)){
if (species[i] == species[j]){
next
}
else
{
fg=as.character(species[i])
bg=as.character(species[j])
print(paste(species[i],species[j],sep=" "))
fg1<-a[a$V1==fg ,c(1,exon+2)]
bg1<-a[a$V1==bg,c(1,exon+2)]
if (maxquan < quantile(fg1[,2],0.75,na.rm=T)){maxquan=quantile(fg1[,2],0.75) }
wilcox.test(fg1[,2],bg1[,2],alternative = "two.sided")->K
P1<-data.frame(names=paste(fg,"vs",bg,sep='_'),p.value=K$p.value)
P<-rbind(P,P1)
}
}
}
options(scipen=0,"digits"=2)
P$qvalue<-p.adjust(P$p.value, method = "BH")

P$V1<-format(P$qvalue,scientific=T)
name=paste("exon",exon,"_pvalues",sep="")
write.table(P,file=name,quote=F,sep="\t",col.names=F,row.names=F)
title=paste("Variation in GC % in Exon", exon ,"in different groups of species",sep=" ")
pdf(paste("exon",exon,".pdf",sep=""),height=50,width=50)
par(mai=c(4,4,2,1),mgp=c(13,0.5,0.1))
boxplot(a[,exon+2]~a$V1,main=title,xlab="Species groups", ylim=c(min(a[,exon+2],na.rm=T),as.numeric(maxquan)+1+(2*(length(P[P$qvalue<0.05,3])))),ylab="GC %", col="Lightsalmon",border="Salmon",las=2,cex=3,cex.main=4,cex.axis=3,cex.lab=4)
start=maxquan
for ( i in seq(1,len,1)){
for (j in seq(2,len,1)){
if (species[i] == species[j]){
next
}
else
{
fg=as.character(species[i])
bg=as.character(species[j])
seg=paste(fg,"vs",bg,sep='_')
P[P$names==seg,3]-> qval
P[P$names==seg,4] -> qvalchar
if(qval > 0.05){
next
}
else
{
segments(i,start,j,start,lty=3,col="purple")
text(((i+j)/2),start+1,labels=qvalchar,cex=2)
}
}
start = start+2
}
}
dev.off()
}

## Now for generating plot for exon 1a of Primates.

d=read.table(file="boxplot_data",header=F,fill=T,na.strings = "NA",sep='\t')
a<-data.frame(d[d$V1=="Primates",c(1,4)])
title=paste("Variation in GC % in Exon1a in Primates species",sep=" ")
pdf("exon1a.pdf",height=50,width=50)
par(mai=c(4,4,2,1),mgp=c(13,0.5,0.1))
boxplot(a$V4,main=title,xlab="Primates", ylab="GC %", col="Lightsalmon",border="Salmon",las=2,cex=3,cex.main=4,cex.axis=3,cex.lab=4)
dev.off()
