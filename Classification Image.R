#images comparison

library(transport)

#First picture(ISFA)
imageISFA=read.csv("C:/Users/Guillaume GALLION/Documents/cours/MASTER/SEMESTRE 2/TER/application/2e application/ISFA.csv", dec=',',header = F)
imageISFA=imageISFA[1:1000,] #we take only the first 10 000 pixels
matriceISFA=as.matrix(imageISFA) #we put the data in a matrix
x <- type.convert(matriceISFA, dec=".") #we convert the data to a decimal value
head(x,10) #to see the top 10 pixels
#we build an object of class "pp" from a matrix to be able to apply wasserstein (The class "pp" represents discrete measures with some fixed mass at any of finitely many locations)
ISFA=pp(x)



#Second picture(LYON) - same process
imageLYON=read.csv("C:/Users/Guillaume GALLION/Documents/cours/MASTER/SEMESTRE 2/TER/application/2e application/LYON.csv", dec=',',header = F)
imageLYON=imageLYON[1:1000,]
matriceLYON=as.matrix(imageLYON)
y <- type.convert(matriceLYON, dec=".")
head(y,10)
LYON=pp(y)


#Third picture(STADE) - same process
imageSTADE=read.csv("C:/Users/Guillaume GALLION/Documents/cours/MASTER/SEMESTRE 2/TER/application/2e application/STADE.csv", dec=',',header = F)
imageSTADE=imageSTADE[1:1000,]
matriceSTADE=as.matrix(imageSTADE)
z <- type.convert(matriceSTADE, dec=".")
head(z,10)
GROUPAMASTADIUM=pp(z)



#wasserstein's distance
wasserstein(ISFA,LYON,p=2) 
wasserstein(ISFA,GROUPAMASTADIUM,p=2) 
wasserstein(LYON,GROUPAMASTADIUM,p=2) 



