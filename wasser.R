install.packages("transport")
library(transport)

#graphic with 2 Normal Distribution
x=curve(dnorm(x, mean=1, sd=1), from = -2, to = 105) #Normal Distribution in 1
y=curve(dnorm(x, mean=50, sd=1), from = -2, to = 105)#Normal Distribution in 50
z=curve(dnorm(x, mean=100, sd=1), from = -2, to = 105)#Normal Distributione in 100
plot.new() 
par(mar=c(4,4,4,4))
plot(x,type="l",main="Gaussian Function",font.main=2,cex.main=2,col="blue",axes=F,xlab="",ylab="") 
axis(2, ylim=c(0,0.4),col="black",col.axis="black",at=seq(0, 0.4, by=0.1)) 
legend("topleft",inset=0.13, legend=c("Mean=1", "Mean=50","Mean=100"),
       col=c("blue", "red","green"), text.font=4,lty=1:1, cex=0.7,bg='lightblue')
mtext("Y",side=2,line=2.2,col="black") 

par(new = T) 
plot(y,type="l",col="red",axes=F,xlab="",ylab="",ylim=c(0,0.4)) 
par(new = T) 
plot(z,type="l",col="green",axes=F,xlab="",ylab="",ylim=c(0,0.4)) 
axis( 1 , ylim=c(0,6),col="black",col.axis="black",at=seq(-5, 105, by=10)) 
mtext("X",side=1,line=2.5,col="black") 






par(mfrow=c(1,1))


#graphic wasserstein's Distance when we switch the mean or the standard deviation

x=vector("numeric", 100)
e1=rnorm(100, mean=0, sd=1)
for (i in seq(1, 100)){
  e2=rnorm(100, mean=i, sd=1)
  x[i]=wasserstein1d(e1, e2, p=2,wa = NULL, wb = NULL)
}
plot(x,type="l",add=TRUE)

y=vector("numeric", 100)
e1=rnorm(100, mean=0, sd=1)
for (i in seq(1, 100)){
  e2=rnorm(100, mean=0, sd=i)
  y[i]=wasserstein1d(e1, e2, p=2,wa = NULL, wb = NULL)
}
plot(y,type="l")

plot.new() 
par(mar=c(4,4,3,5)) 
plot(x,type="l",main="Wasserstein's distance",font.main=2,col="blue",axes=F,xlab="",ylab="") 
axis(2, ylim=c(0,110),col="black",col.axis="black",at=seq(0, 110, by=10)) 
mtext("Y",side=2,line=2.5,col="black")  
par(new = T) 
plot(y,type="l",col="red",axes=F,xlab="",ylab="",ylim=c(0,110)) 
axis( 1 , ylim=c(0,110),col="black",col.axis="black",at=seq(0, 100, by=10)) 
mtext("X",side=1,line=2.5,col="black") 
legend("topleft",inset=0.08, legend=c("mean=x, sd=1", "mean=0, sd=x"),
       col=c("blue", "red"), text.font=4,lty=1:1, cex=1,bg='lightblue')




#graphic Wasserstein's distance vs Kolmogororev distance

e1=rnorm(100, mean=1, sd=1)

x=vector("numeric", 6)
e1=rnorm(100, mean=0, sd=1)
for (i in seq(2,6)){
  e2=rnorm(100, mean=i, sd=1)
  x[i]=wasserstein1d(e1, e2, p=2,wa = NULL, wb = NULL)
}

y=vector("numeric", 6)
for (i in seq(2, 6)){
  e2=rnorm(100, mean=i, sd=1)
  y[i]=ks.test(e1, e2)$statistic
}

plot.new() 
par(mar=c(4,4,3,5))
plot(x,type="l",main="Wasserstein vs Kolmogorov",col="blue",axes=F,xlab="",ylab="") 
axis(2, ylim=c(0,6),col="black",col.axis="black",at=seq(0, 6, by=1)) 
mtext("Y",side=2,line=2.5,col="black")  
par(new = T) 
plot(y,type="l",col="red",axes=F,xlab="",ylab="",ylim=c(0,6)) 
axis( 1 , ylim=c(0,6),col="black",col.axis="black",at=seq(0, 6, by=1)) 
mtext("X",side=1,line=2.5,col="black") 
legend("topleft",inset=0.08, legend=c("Wasserstein's Distance", "Kolmogorov's Distance"),
       col=c("blue", "red"), text.font=4,lty=1:1, cex=1,bg='lightblue')



#same graphic but with a larger scale

x=vector("numeric", 100)
e1=rnorm(100, mean=1, sd=1)
for (i in seq(1,99)){
  e2=rnorm(100, mean=i, sd=1)
  x[i+1]=wasserstein1d(e1, e2, p=2,wa = NULL, wb = NULL)
}

y=vector("numeric", 100)
for (i in seq(1, 99)){
  e2=rnorm(100, mean=i, sd=1)
  y[i+1]=ks.test(e1, e2)$statistic
}

plot.new() 
par(mar=c(4,4,3,5))
plot(x,type="l",main="Wasserstein vs Kolmogorov",col="blue",axes=F,xlab="",ylab="") 
axis(2, ylim=c(0,4),col="black",col.axis="black",at=seq(0, 100, by=10)) 
mtext("Y",side=2,line=2.5,col="black")  
par(new = T) 
plot(y,type="l",col="red",axes=F,xlab="",ylab="",ylim=c(0,100)) 
axis( 1 , ylim=c(0,4),col="black",col.axis="black",at=seq(0, 100, by=10)) 
mtext("X",side=1,line=2.5,col="black") 
legend("topleft",inset=0.08, legend=c("Wasserstein's Distance", "Kolmogorov's Distance"),
       col=c("blue", "red"), text.font=4,lty=1:1, cex=1,bg='lightblue')

