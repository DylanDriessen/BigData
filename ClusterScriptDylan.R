library(stats)
dataSet2 <- utf8Data

#Geeft alle unieke ID's van de naam Rob
nameSet <- unique(dataSet2[dataSet2$entity=='John Powell',])
View(nameSet)

#Geeft alle unieke namen van persoon in nameSet PER id
nameDataSet <- unique(merge(nameSet, dataSet2, by="id"))

