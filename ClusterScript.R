
dataSet <- utf8Data
names(dataSet) <- c("id", "name")


#For each id give the names

idDataSet <- as.data.frame(dataSet[,1], drop=FALSE)
names(idDataSet) <- c('id')

idDataSet <- merge(idDataSet, dataSet,by="id")

#For each name give id's
nameDataSet <- as.data.frame(dataSet[,2], drop=FALSE)
names(nameDataSet) <- c('name')
nameDataSet <- unique(nameDataSet)

nameDataSet <- merge(nameDataSet, dataSet, by="name")

