

setwd("~/R working directory")
dataSet = data.frame(lapply( read.csv("Alfresco.csv"), as.character), stringsAsFactors = FALSE)
newDataSet <- data.frame(id=numeric(), name=factor())

for (i in 1:nrow(dataSet)) {
  
  columnDelimited <- strsplit(as.character(dataSet[i,1]), ";")
  properTableDelimited <- columnDelimited[[1]]
  
  id <- as.numeric(properTableDelimited[1])
  name <- properTableDelimited[2]
  row <- data.frame(id, name)
  newDataSet <- rbind(newDataSet, row)
}

View(newDataSet)
View(dataSet)