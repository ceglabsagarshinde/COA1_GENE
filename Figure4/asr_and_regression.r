library(phytools)
a=read.table("wir_data_ordered.txt",header=F,row.names=1)
t=read.tree("species24forfigure.nwk")
a$V3 = a$V3/100
a$V4 = a$V4/100
a$V5 = a$V5/100
column_names=c("W","I","R")
i=1
b=as.data.frame(a[,i+1])
rownames(b)=rownames(a)
colnames(b)="bv"
b<-setNames(b$bv,rownames(b))
fit<-fastAnc(t,b,vars=TRUE,CI=FALSE)[1]
c=as.data.frame(fit)
colnames(c)=column_names[i]
i=2
b=as.data.frame(a[,i+1])
rownames(b)=rownames(a)
colnames(b)="bv"
b<-setNames(b$bv,rownames(b))
fit<-fastAnc(t,b,vars=TRUE,CI=FALSE)[1]
c[ , ncol(c) + 1] <- fit
i=3
b=as.data.frame(a[,i+1])
rownames(b)=rownames(a)
colnames(b)="bv"
b<-setNames(b$bv,rownames(b))
fit<-fastAnc(t,b,vars=TRUE,CI=FALSE)[1]
c[ , ncol(c) + 1] <- fit
colnames(c)=column_names
b=a[,-1]
colnames(b)=column_names
d=rbind(b,c)
ma=as.matrix(d[,])
geo = factor(a$V2)
(mycol <- c("red","blue")[geo])
png("wir_phylogeny_plot.png",height=12,width=22,units = "in",res=200)
par(mfrow= c(1, 2),mar=c(3.5,2.5,4,1))
plot(t, tip.color = mycol,edge.width=3,adj=0.05,cex=1.5)
nodelabels(node=1:47,pie=ma[,],piecol=c("white","pink","red"),cex=0.75,adj=c(-1.75,0.5))
library(phylolm)
a=read.table("wir_data_ordered.txt",header=F)
head(a)
colnames(a)=c("species","gene_status","W","I","R")
rownames(a)=a[,1]
###############MPLE###############
fitwmple=phyloglm(gene_status~W,a,t, method = c("logistic_MPLE"), btol = 10, log.alpha.bound = 4,start.beta=NULL, start.alpha=NULL,boot = 2000, full.matrix = TRUE)
cc1=coef(fitwmple)
summary(fitwmple)
#####################IG10#########
fitwig10=phyloglm(gene_status~W,a,t, method = c("logistic_IG10"), btol = 20, log.alpha.bound = 4,start.beta=NULL, start.alpha=NULL,boot = 2000, full.matrix = TRUE)
cc2=coef(fitwig10)
summary(fitwig10)
####################################
t(table(a$gene_status,a$W))->M
plot(rep(c(0,6.2,11,12,15.6,17,18,24,25,27,37.5,51,60,67,72.3,76,95),2),c(rep(1,17),rep(0,17)),cex=c(as.vector(M[,2]),as.vector(M[,1]))/3,pch=19, xlab="",ylab='',xlim=c(0,100),axes=F)
axis(1)
axis(2, at = seq(0,1,by=1), las = 1)
box()
mtext("Loss",side=2,line=1.5,at=0)
mtext("Percentage of white muscle (FG) fiber",side=1,line=2,at=50,cex=1.4)
mtext(substitute(paste(italic('COA1'), " gene")),side=2,line=2,at=0.5,cex=1.5)
mtext("Retention",side=2,line=1.5,at=1)
curve(plogis(cc1[1]+cc1[2]*x),col="red",add=TRUE,lwd=2)
legend(65,0.8, "logistic_MPLE\nIntercept = 3.8877996\nSlope = -0.0593965\np = 0.039\nn = 24",xjust = 0.5,yjust = 0.5,x.intersp = 0.2,y.intersp = 0.8,adj = c(0, 0.5),bty='n')
curve(plogis(cc2[1]+cc2[2]*x),col="red",add=TRUE,lwd=2)
legend(55,0.4, "logistic_IG10\nIntercept = 3.48855\nSlope = -0.058943\np = 0.02434\nn = 24",xjust = 0.5,yjust = 0.5,x.intersp = 0.2,y.intersp = 0.8,adj = c(0, 0.5),bty='n')
dev.off()
####################
