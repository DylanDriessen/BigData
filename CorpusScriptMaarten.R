library(tm)
library(doParallel)
library(zoom)
library(skmeans)
library(plyr)

uniqueID <- unique(cleanUtf8Data$id)
documentNamesString <- NULL
idSet <- data.frame(names=factor())
documentNamerow <- data.frame(names=factor())


#Corpus maken
ptm <- proc.time()
for(i in 1:NROW(uniqueID)){
  
  idSet <- cleanUtf8Data[cleanUtf8Data$id == uniqueID[i],]
  documentNamerow <- paste(idSet$entity, collapse = " ")
  
  documentNamesString <- rbind(documentNamesString, documentNamerow)
  idSet <- data.frame(name=factor())
  documentNamerow <- data.frame(names=factor())
}
proc.time()[3]-ptm[3]

#Sparse matrix maken
freqDoc <- data.frame(id = numeric(), name = String(), freq = numeric())
row <- data.frame(names=String())

ptm <- proc.time()
for(i in 1:NROW(uniqueID)){
  
  idSet <- cleanUtf8Data[cleanUtf8Data$id == uniqueID[i],]
  row <- count(idSet, idSet$entity)
  
  
  idSet <- data.frame(name=factor())
  row <- data.frame(names=String())
}
proc.time()[3]-ptm[3]

freqDoc.sparse <- sparseMatrix(i =freqDoc$id)


idSet <- cleanUtf8Data[cleanUtf8Data$id == uniqueID[100],]
row <- count(idSet, idSet$entity)
