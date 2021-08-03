library("phytools")
a<-read.tree("species_coa1.nwk.txt")
d<-read.tree("species_pdx1.nwk.txt")

b<-read.table("COA1_GCPERCENT.txt", row.names=1)
c<-read.table("PDX1_GCPERCENT.txt", row.names=1)

low_gc_coa1<-setNames(b$V2,rownames(b))
low_gc_pdx1<-setNames(c$V2,rownames(c))

coa.contMap<-contMap(a,low_gc_coa1,plot=FALSE,res=400)
pdx.contMap<-contMap(d,low_gc_pdx1,plot=FALSE,res=400)

coa.contMap<-setMap(coa.contMap,c("blue","cyan","green","yellow","red"))	
pdx.contMap<-setMap(pdx.contMap,c("blue","cyan","green","yellow","red"))		

jpeg("low_GC_COA1_PDX1.jepg",width=2000,height=1700)
par(mfrow=c(1,2),xpd=T)
plot(coa.contMap,fsize=c(1.9,1.5),leg.txt="Low GC% COA1",lwd=12)
plot(pdx.contMap,fsize=c(1.9,1.5),leg.txt="Low GC% PDX1",direction="leftwards",main="LOW GC%",lwd=12)
par(mar=c(5.1,4.1,4.1,2.1))
dev.off()	


b<-read.table("COA1_GCPERCENT.txt", row.names=1)
c<-read.table("PDX1_GCPERCENT.txt", row.names=1)
HIGH_gc_coa1<-setNames(b$V3,rownames(b))
HIGH_gc_pdx1<-setNames(c$V3,rownames(c))

coa.contMap<-contMap(a,HIGH_gc_coa1,plot=FALSE,res=400)
pdx.contMap<-contMap(d,HIGH_gc_pdx1,plot=FALSE,res=400)

coa.contMap<-setMap(coa.contMap,c("blue","cyan","green","yellow","red"))	
pdx.contMap<-setMap(pdx.contMap,c("blue","cyan","green","yellow","red"))		

jpeg("High_GC_COA1_PDX1.jepg",width=2000,height=1700)
par(mfrow=c(1,2),xpd=T)
plot(coa.contMap,fsize=c(1.9,1.5),leg.txt="High GC% COA1",lwd=12)
plot(pdx.contMap,fsize=c(1.9,1.5),leg.txt="High GC% PDX1",direction="leftwards",main="High GC%",lwd=12)
par(mar=c(5.1,4.1,4.1,2.1))
dev.off()	
