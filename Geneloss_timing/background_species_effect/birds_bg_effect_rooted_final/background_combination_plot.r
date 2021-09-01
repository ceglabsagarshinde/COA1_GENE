##This script is to plot the effect of different background species combination on pseudogenization timing estimation.
#This script is using the output of previous script which compiled the output from all the combinations
#The initial file required has name outfilecompile
#You can plot it in JPEG or PDF format. Default is set for JPEG.
library(ggplot2)
library(grid)
require(gridExtra)
a=read.table(file="outfilecompile",header=T)
b=a[,c(1,3,4,10,12)]
#jpeg(file="Bg_combination.jpeg", width=1500, height=1250)
p=list()
i=1
pdf("background_effect.pdf", width=30, height=25)
for (mdl in as.character(unique(b$model))){
print(mdl)
c=b[b$model==mdl,]
print(head(c))
theme_set( theme_minimal() + theme(plot.title = element_text(hjust = 0.5),text = element_text(size=15),legend.position = "right",axis.line = element_line(color = "black",size = 0.7, linetype = "solid")))  
p[[i]]=ggplot(c, aes(x = nBg, y = Tp)) + labs(caption = paste(mdl," nucleotide frequency model", sep="")) + ggtitle("Pseudogenization time estimation using single substitution rate") + geom_line(aes(color = Foreground))  + scale_x_continuous(breaks=seq(0, 100, 5),name ="Number of Background species (nBg)")+ scale_y_continuous(breaks=seq(0, 75, 5),name ="Time of pseudogenization (MYA)")
theme_set( theme_minimal() + theme(plot.title = element_text(hjust = 0.5),text = element_text(size=15),legend.position = "right",axis.line = element_line(color = "black",size = 0.7, linetype = "solid")))
p[[i+1]]=ggplot(c, aes(x = nBg, y = Tp2)) + labs(caption = paste(mdl," nucleotide frequency model", sep="")) + ggtitle("Pseudogenization time estimation using different substitution rate") + geom_line(aes(color = Foreground)) + scale_x_continuous(breaks=seq(0, 100, 5),name ="Number of Background species (nBg)")+ scale_y_continuous(breaks=seq(0, 75, 5),name ="Time of pseudogenization (MYA)")
i=i+2
}
print(do.call(grid.arrange,p))
dev.off()
