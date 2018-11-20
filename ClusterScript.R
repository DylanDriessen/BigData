
dataSet <- utf8Data
names(dataSet) <- c("id", "name")


#For each id give the names

idDataSet <- as.data.frame(dataSet[,1], drop=FALSE)
names(idDataSet) <- c('id')

idDataSet <- merge(idDataSet, dataSet,by="id")
idSet1 <- subset(idDataSet, i < 140451)

#For each name give id's
nameDataSet <- as.data.frame(dataSet[,2], drop=FALSE)
names(nameDataSet) <- c('name')
nameDataSet <- unique(nameDataSet)

nameDataSet <- merge(nameDataSet, dataSet, by="name")



#Voor elke naam alle namen FUCKING HELL DAS TE GROOT, ZELFS ID AL IN 1/4 GEDEELD
completeDataSet1 <- merge(nameDataSet, idSet1, by="name")

