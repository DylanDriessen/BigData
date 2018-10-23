library('readxl')
setwd()
dataSet = data.frame(lapply( read_excel("Alfresco.xlsx"), as.character), stringsAsFactors = FALSE)
dataSet <- dataSet[-1, ]
print(NROW(dataSet))
newDataSet <- data.frame(id=numeric(), name=factor())

for (i in 1:NROW(dataSet)) {
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
    name <- gsub('"', "", gsub("Â", "", properTableDelimited[2]))
    row <- data.frame(id, name)
    
    if (!grepl("\\W", gsub("\\s", "", gsub('\\.', "", gsub('\\-', "", name))))) {
      newDataSet <- rbind(newDataSet, row)
    }
    containsNumber <- FALSE
  }
  else{
    id <- 0
    name <- dataSet[i]
    row <- data.frame(id, name)
    newDataSet <- rbind(newDataSet, row)
  }
}

#test