library(stats)
library(plyr)
library(wordcloud)
library(wordcloud2)
library(viridis)
library(dplyr)

dataSet2 <- cleanUtf8Data
#Te kiezen naam
name <- 'john_powel'

#Geeft alle unieke ID's van de naam ".."
nameSetUnique <- unique(dataSet2[dataSet2$name==name,])

#Geeft alle unieke namen van personen verbonden met persoon hierboven in nameSet PER id
nameDataSetUnique <- unique(merge(nameSetUnique, dataSet2, by="id"))

#Tel frequentie van naam
library(plyr)
frequencyDataSetUnique <- count(nameDataSetUnique, nameDataSetUnique$name.y)

#Wordcloud
par(mfrow=c(1,1))
pal = brewer.pal(8,"Dark2")
set.seed(1234)
png("wordcloudUnique.png", width=1280,height=800)
wordcloud(frequencyDataSetUnique$`nameDataSetUnique$name.y`, frequencyDataSetUnique$n,scale=c(8, 2),
          max.words=Inf, random.order=FALSE, rot.per=.15,
          colors = pal)
dev.off()

#Nu alles geven, dus niet uniek

#Geeft alle ID's van de naam ".."
nameSet <- (dataSet2[dataSet2$name==name,])

#Geeft alle namen van personen verbonden met persoon hierboven in nameSet PER id
nameDataSet <- (merge(nameSet, dataSet2, by="id"))

#Tel frequentie van naam
frequencyDataSet2 <- count(nameDataSet, nameDataSet$name.y)

#Wordcloud
par(mfrow=c(1,1))
pal = brewer.pal(8,"Dark2")
set.seed(1234)
png("wordcloud.png", width=1280,height=800)
wordcloud(frequencyDataSet2$`nameDataSet$name.y`, frequencyDataSet2$n, min.freq=2,scale=c(8, 2),
          max.words=Inf, random.order=FALSE, rot.per=.15,
          colors = pal)
dev.off()
  
  
