# Data source
#	http://newspaper.miniconomy.net/2011/02/25/statistics-44/
# Todo
#	use margins as on http://www.cyclismo.org/tutorial/R/tables.html#manipulations
#	use rose plot as on http://addictedtor.free.fr/graphiques/RGraphGallery.php?graph=123

x=read.csv("resources_data.csv",header=T,row.names=1)
pdf("resources_plot.pdf");
layout(mat=matrix(seq(1,6),2,3,byrow=T))#,width=lcm(5),height=lcm(10))
barplot_ <- function(height,main) {
barplot(height=height,legend=T,beside=T,main=main,col=rainbow(nrow(height)),las=3,args.legend=list(ncol=2,cex=0.5,x="topleft"),cex.names=0.5)
}

main_pre='stats by city'
barplot_(as.matrix(x[-nrow(x),]),main=main_pre)
barplot_(as.matrix(x[-nrow(x),-which(colnames(x)=="Oil")]),main=sprintf('%s, ex-oil',main_pre))
temp=as.matrix(x[-nrow(x),which(colnames(x)=="Diamonds")])
rownames(temp)=rownames(x[-nrow(x),])
barplot_(temp,main=sprintf('%s, diamonds',main_pre))

main_pre='stats by resource'
barplot_(t(as.matrix(x[-nrow(x),])),main=main_pre)
barplot_(t(as.matrix(x[-nrow(x),-which(colnames(x)=="Oil")])),main=sprintf('%s, ex-oil',main_pre))
temp=t(as.matrix(x[-nrow(x),which(colnames(x)=="Diamonds")]))
colnames(temp)=rownames(x[-nrow(x),])
barplot_(temp,main=sprintf('%s, diamonds',main_pre))

dev.off()
