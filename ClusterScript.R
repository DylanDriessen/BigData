
dataSet <- utf8Data
names(dataSet) <- c("id", "name")


#For each id give the names

idDataSet <- as.data.frame(dataSet[,1], drop=FALSE)
names(idDataSet) <- c('id')

idDataSet <- merge(idDataSet, dataSet,by="id")

#Gebruik kleiner aantal documenten
<<<<<<< HEAD
idSet1 <- subset(idDataSet, id < 140451)
=======
idSet1 <- subset(idDataSet, id < 3119)
>>>>>>> 72c1c0869e5e878e17dc3ee23806384b90d8aba8

#For each name give id's
nameDataSet <- as.data.frame(dataSet[,2], drop=FALSE)
names(nameDataSet) <- c('name')
nameDataSet <- unique(nameDataSet)

nameDataSet <- merge(nameDataSet, dataSet, by="name")

#Voor elke naam alle namen
<<<<<<< HEAD
#completeDataSet1 <- merge(nameDataSet, idSet1, by="name")
=======
completeDataSet1 <- merge(nameDataSet, idSet1, by="id")
>>>>>>> 72c1c0869e5e878e17dc3ee23806384b90d8aba8

#Voor specifieke naam alle gelinkte namen
library(plyr)
specificDataSet <- merge(subset(nameDataSet, name=="Jos Snellings"), idSet1, by="id")
frequencyDataSet <- count(specificDataSet, 'name.y')

#specifieke wordcloud
library(wordcloud)
<<<<<<< HEAD
library(viridis)
pal = brewer.pal(8,"Dark2")
#png("wordcloud_test.png", width=12, height=8, units='in', res=300)
#wordcloud(frequencyDataSet$name.y, frequencyDataSet$freq, random.order = FALSE, max.words = 10)
#wordcloud(frequencyDataSet$name.y,frequencyDataSet$freq, max.words =100,min.freq=3,scale=c(4,.5), 
#          random.order = FALSE,rot.per=.5,vfont=c("sans serif","plain"),colors=palette())
wordcloud(frequencyDataSet$name.y, frequencyDataSet$freq, scale=c(2, .3), min.freq=10,
                     max.words=Inf, random.order=FALSE, rot.per=.35, random.color = F, use.r.layout=FALSE,
          colors = pal)
=======

wordcloud(frequencyDataSet$name.y, frequencyDataSet$freq, random.order = FALSE)

#Cluster pogin 1
namesFreqency <- count(dataSet, 'name')

#Corpus
corpus = tm:Corpus(tm::VectorSource(subset()))
>>>>>>> 72c1c0869e5e878e17dc3ee23806384b90d8aba8
