
dataSet <- utf8Data
names(dataSet) <- c("id", "name")


#For each id give the names

idDataSet <- as.data.frame(dataSet[,1], drop=FALSE)
names(idDataSet) <- c('id')

idDataSet <- merge(idDataSet, dataSet,by="id")

#Gebruik kleiner aantal documenten
idSet1 <- subset(idDataSet, id < 140451)

#For each name give id's
nameDataSet <- as.data.frame(dataSet[,2], drop=FALSE)
names(nameDataSet) <- c('name')
nameDataSet <- unique(nameDataSet)

nameDataSet <- merge(nameDataSet, dataSet, by="name")

#Voor elke naam alle namen
completeDataSet1 <- merge(nameDataSet, idSet1, by="name")

#Voor specifieke naam alle gelinkte namen
library(plyr)
specificDataSet <- merge(subset(nameDataSet, name=="A. Acharya"), idSet1, by="id")
frequencyDataSet <- count(specificDataSet, 'name.y')

#specifieke wordcloud
library(wordcloud)

wordcloud(frequencyDataSet$name.y, frequencyDataSet$freq, random.order = FALSE)

