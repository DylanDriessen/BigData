
library('readxl')
setwd("~/R working directory")
dataSet = data.frame(lapply( read_excel("Alfresco.xlsx"), as.character), stringsAsFactors = FALSE)
print(head(dataSet, 4))
View(dataSet)
newDataSet <- data.frame(id=numeric(), name=factor())


for (i in 1:200) {
  
  columnDelimited <- strsplit(as.character(dataSet[i,1]), ',"')
  properTableDelimited <- columnDelimited[[1]]
  print(properTableDelimited)
  id <- as.numeric(properTableDelimited[1])
  name <- properTableDelimited[2]
  row <- data.frame(id, name)
  newDataSet <- rbind(newDataSet, row)
  containsNumber <- FALSE
}

View(newDataSet)
