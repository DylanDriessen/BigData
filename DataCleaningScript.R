library('readxl')
setwd("~/R working directory")
dataSet = data.frame(lapply( read_excel("Alfresco.xlsx"), as.character), stringsAsFactors = FALSE)
dataSet <- dataSet[-c(1), ]
View(dataSet)
newDataSet <- data.frame(id=numeric(), name=factor())

for (i in 1:200) {
  containsNumber <- FALSE
  for (j in 0:9) {
    if (grepl(j, dataSet[i])) {
      containsNumber <- TRUE
    }
  }
  if (containsNumber) {
    columnDelimited <- strsplit(as.character(dataSet[i]), ',"')
    properTableDelimited <- columnDelimited[[1]]
    
    id <- as.numeric(properTableDelimited[1])
    name <- gsub('"', "", properTableDelimited[2])
    row <- data.frame(id, name)
    newDataSet <- rbind(newDataSet, row)
    
    containsNumber <- FALSE
  }
  else{
    id <- 0
    name <- dataSet[i,1]
    row <- data.frame(id, name)
    newDataSet <- rbind(newDataSet, row)
  }
}

View(newDataSet)
