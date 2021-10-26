a=read.table("outfilecompile_combined",header=F)
a$V1<-gsub("_", " ", a$V1)
jpeg("Pseudogenization_time_compile.jpeg",width=3000, height=2500)
par(mfrow=c(2,2),mar=c(18,6,4,3),oma=c(2,3,6,3)) ##mar decide plot margin while oma decide outer margin
#please see https://www.r-graph-gallery.com/74-margin-and-oma-cheatsheet.html for visualization
for ( i in unique(a$V2)){
b<-data.frame(a[a$V2==i,])
boxplot(b$V3~b$V1,xlab='',ylab='',col="blueviolet",border="darkblue",las=2,main=bquote(T[p]~estimation~using~codon~frequency~model~.(i)),cex=3,cex.lab=2,cex.axis=2,cex.main=3.2,ylim=c(-10,80),xaxt='n')
c=as.character(unique(sort(as.character(b$V1))))
for(nam in seq(1, length(c), by = 1)){
axis(1, at = nam,labels=substitute(''~italic(j)~'', list(j=c[nam])), las=2,cex.axis=1.5)}
##we are keeping xlab and ylab blank such that we can manipulate their position manually using title
title(ylab=bquote(T[p]), line=3, cex.lab=3)
title(xlab="Species",line=15,cex.lab=3)
boxplot(b$V4~b$V1,xlab='',ylab='', col="blue",border="darkblue",las=2,main=bquote(T[p2]~estimation~using~codon~frequency~model~.(i)),cex=3,cex.lab=2,cex.axis=2,cex.main=3.2,ylim=c(-10,80),xaxt='n')
c=as.character(unique(sort(as.character(b$V1))))
for(nam in seq(1, length(c), by = 1)){
axis(1, at = nam,labels=substitute(''~italic(j)~'', list(j=c[nam])), las=2,cex.axis=1.5)}
title(ylab=bquote(T[p2]), line=3, cex.lab=3)
title(xlab="Species",line=15,cex.lab=3)
}
mtext("Variation in pseudogenization time estimation in different species", side = 3, line = 2, outer = TRUE,cex=4)
##This is to put a common title on the plot
dev.off()

