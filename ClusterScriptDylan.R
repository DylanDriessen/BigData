library(stats)
dataSet2 <- utf8Data

#Geeft alle unieke ID's van de naam Rob
nameSet <- unique(dataSet2[dataSet2$entity=='Kevin Cochrane',])
View(nameSet)

#Geeft alle unieke namen van personen verbonden met persoon hierboven in nameSet PER id
nameDataSet <- unique(merge(nameSet, dataSet2, by="id"))
View(nameDataSet)

#Tel frequentie van naam
library(plyr)
frequencyDataSet2 <- count(nameDataSet, 'entity.y')
View(frequencyDataSet2)

#Wordcloud
library(wordcloud)
library(viridis)
pal = brewer.pal(8,"Dark2")
set.seed(1234)
wordcloud(frequencyDataSet2$entity.y, frequencyDataSet2$freq, scale=c(2, .5), min.freq=2,
          max.words=Inf, random.order=FALSE, rot.per=.15,
          colors = pal)