library(stats)
library(plyr)
library(wordcloud)
library(viridis)

dataSet2 <- utf8Data
#Te kiezen naam
name <- 'Laurent Morlet'

#Geeft alle unieke ID's van de naam ".."
nameSetUnique <- unique(dataSet2[dataSet2$entity==name,])
#View(nameSet)

#Geeft alle unieke namen van personen verbonden met persoon hierboven in nameSet PER id
nameDataSetUnique <- unique(merge(nameSetUnique, dataSet2, by="id"))
#View(nameDataSet)

#Tel frequentie van naam
frequencyDataSetUnique <- count(nameDataSetUnique, 'entity.y')
#View(frequencyDataSet2)

#Wordcloud
par(mfrow=c(1,1))
pal = brewer.pal(8,"Dark2")
set.seed(1234)
png("wordcloudUnique.png", width=1280,height=800)
wordcloud(frequencyDataSetUnique$entity.y, frequencyDataSetUnique$freq, min.freq=2,scale=c(8, 2),
          max.words=Inf, random.order=FALSE, rot.per=.15,
          colors = pal)
dev.off()

#Nu alles geven, dus niet uniek

#Geeft alle ID's van de naam ".."
nameSet <- (dataSet2[dataSet2$entity==name,])
View(nameSet)

#Geeft alle namen van personen verbonden met persoon hierboven in nameSet PER id
nameDataSet <- (merge(nameSet, dataSet2, by="id"))
View(nameDataSet)

#Tel frequentie van naam
frequencyDataSet2 <- count(nameDataSet, 'entity.y')
View(frequencyDataSet2)

#Wordcloud
par(mfrow=c(1,1))
pal = brewer.pal(8,"Dark2")
set.seed(1234)
png("wordcloud.png", width=1280,height=800)
wordcloud(frequencyDataSet2$entity.y, frequencyDataSet2$freq, min.freq=2,scale=c(8, 2),
          max.words=Inf, random.order=FALSE, rot.per=.15,
          colors = pal)
dev.off()
  
  