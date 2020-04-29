#newspapers classification

#library
library(quanteda)
library(wordcloud)
library(readtext)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(tm)
library(scatterplot3d)
library(transport)


#read text of L'Equipe
texte1=readtext("C:/Users/Guillaume GALLION/Documents/cours/MASTER/SEMESTRE 2/TER/2802lequipe.txt", encoding="UTF-8")

#files become a corpus
texte1 <- Corpus(VectorSource(texte1))
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
texte1 <- tm_map(texte1, toSpace, "/")


#clean and homogenize the text
texte1 <- tm_map(texte1, removeNumbers) # Supprimer les nombres
texte1 <- tm_map(texte1, removeWords, stopwords("french")) # Supprimer les mots vides francais
texte1 <- tm_map(texte1, content_transformer(tolower)) # mettre le texte en minuscule
texte1 <- tm_map(texte1, removePunctuation) # Supprimer les ponctuations

#delete unnecessary words
texte1 <- tm_map(texte1, removeWords, c("plus","deux","mercredi","'","après","face","très","hier")) 

#build a matrix with all the words
documentLEQUIPE <- TermDocumentMatrix(texte1)
matriceLEQUIPE <- as.matrix(documentLEQUIPE)

#decreasing display in matrix of the most frequent words
matriceRange <- sort(rowSums(matriceLEQUIPE),decreasing=TRUE)
final <- data.frame(word = names(matriceRange),freq=matriceRange)

#we remove the word " ' "that we can't remove normally
final=final[2:1000,]

#displays the most frequent words
head(final, 20)

#displays the most frequent numbers in a histogram
wordcloud(words = final$word, freq = final$freq, min.freq = 1,
          max.words=200,main="", random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))




#read text of Figaro
texte2=readtext("C:/Users/Guillaume GALLION/Documents/cours/MASTER/SEMESTRE 2/TER/figaro.txt", encoding="UTF-8")

texte2 <- Corpus(VectorSource(texte2))
texte2 <- tm_map(texte2, toSpace, "/")

texte2 <- tm_map(texte2, removeNumbers)
texte2 <- tm_map(texte2, removeWords, stopwords("french"))
texte2 <- tm_map(texte2, content_transformer(tolower))
texte2 <- tm_map(texte2, removePunctuation)
texte2 <- tm_map(texte2, removeWords, c("les","plus","deux","mercredi","'","après","face","très","hier")) 

documentFIGARO <- TermDocumentMatrix(texte2)
matriceFIGARO <- as.matrix(documentFIGARO)
matriceRange <- sort(rowSums(matriceFIGARO),decreasing=TRUE)
final <- data.frame(word = names(matriceRange),freq=matriceRange)

#we remove the first 2 words that we can't remove normally
final=final[3:1000,]
head(final, 40)

wordcloud(words = final$word, freq = final$freq, min.freq = 5,
          max.words=100, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))




#read text of PARIS MATCH
texte3=readtext("C:/Users/Guillaume GALLION/Documents/cours/MASTER/SEMESTRE 2/TER/match.txt", encoding="UTF-8")

texte3 <- Corpus(VectorSource(texte3))
texte3 <- tm_map(texte3, toSpace, "/")

texte3 <- tm_map(texte3, removeNumbers)
texte3 <- tm_map(texte3, removeWords, stopwords("french"))
texte3 <- tm_map(texte3, content_transformer(tolower))
texte3 <- tm_map(texte3, removePunctuation)
texte3 <- tm_map(texte3, removeWords, c("les","plus","deux","mercredi","'","après","face","très","hier")) 

documentPMATCH <- TermDocumentMatrix(texte3)
matricePMATCH <- as.matrix(documentPMATCH)
matriceRange <- sort(rowSums(matricePMATCH),decreasing=TRUE)
final <- data.frame(word = names(matriceRange),freq=matriceRange)

#we remove the first words that we can't remove normally
final=final[2:1000,]
head(d, 30)

wordcloud(words = final$word, freq = final$freq, min.freq = 5,
          max.words=100, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))





#display of 3d graphics with the databases we have created


par(mfrow=c(1,1))

#read files csv with words of L'EQUIPE
lequipe<- read.csv2("C:/Users/Guillaume GALLION/Documents/cours/MASTER/SEMESTRE 2/TER/lequipe.csv")
#we put the 3 words that define our space
lequipe <- subset(lequipe, select = c(Politic,Entertainment,Economy))
#we convert our matrix into numeric number
lequipe <- type.convert(lequipe, dec=".")
#we display the points in 3d
nuage3d <- scatterplot3d(lequipe,color = "red", main="L'EQUIPE",pch = 16,xlim=c(0,1),ylim=c(0,1),zlim=c(0,1))

#same process for FIGARO
figaro<- read.csv2("C:/Users/Guillaume GALLION/Documents/cours/MASTER/SEMESTRE 2/TER/figaro.csv")
figaro <- subset(figaro, select = c(Politic,Entertainment,Economy))
figaro <- type.convert(figaro, dec=".")
nuage3d <- scatterplot3d(figaro,color = "green", main="FIGARO",pch = 16,xlim=c(0,1),ylim=c(0,1),zlim=c(0,1))

#same process for PARIS MATCH
match<- read.csv2("C:/Users/Guillaume GALLION/Documents/cours/MASTER/SEMESTRE 2/TER/match.csv")
match <- subset(match, select = c(Politic,Entertainment,Economy))
match <- type.convert(match, dec=".")
nuage3d <- scatterplot3d(match,color = "blue",main="PARIS MATCH", pch = 16,xlim=c(0,1),ylim=c(0,1),zlim=c(0,1))



#to apply wasserstein's distance we make matrices with the coordinates of words
matrixlequipe=cbind(c(0.5,0.5,0.1,0.2,0,0.25,0,0.4),c(0,0,0.7,0.5,0.7,0.5,0.8,0.4),c(0.5,0.5,0.2,0.3,0.3,0.25,0.2,0.2))
matrixfigaro=cbind(c(0.4,0.4,0.5,0.35,0.5,0.3,0.4,0.3),c(0,0.2,0,0.3,0,0.3,0.1,0.1),c(0.6,0.4,0.5,0.35,0.5,0.4,0.5,0.6))
matrixmatch=cbind(c(0.8,0.3,0.8,0.7,0.45,0.3,0.45,0.2),c(0.2,0.4,0.1,0.3,0.1,0.3,0.3,0.4),c(0,0.3,0,0,0.45,0.40,0.25,0.4))

#we build an object of class "pp" from a matrix to be able to apply wasserstein (The class "pp" represents discrete measures with some fixed mass at any of finitely many locations)
mlequipe <- pp(matrixlequipe)
mfigaro <- pp(matrixfigaro)
mmatch <-pp(matrixmatch)


#wasserstein's distance
wasserstein(mlequipe,mmatch,p=2)
wasserstein(mlequipe,mfigaro,p=2)
wasserstein(mmatch,mfigaro,p=2)


