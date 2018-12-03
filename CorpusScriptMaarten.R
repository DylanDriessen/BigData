library(tm)
library(doParallel)
library(zoom)
library(skmeans)

uniqueID <- unique(cleanUtf8Data$id)
documentNamesString <- NULL
idNameSet <- data.frame(names=factor())
documentNamerow <- data.frame(names=factor())


#Alleen voor eerste 50 id's
ptm <- proc.time()
for(i in 1:NROW(uniqueID)){
  
  idSet <- cleanUtf8Data[cleanUtf8Data$id == uniqueID[i],]
  documentNamerow <- paste(idSet$entity, collapse = " ")
  
  documentNamesString <- rbind(documentNamesString, documentNamerow)
  idNameSet <- data.frame(name=factor())
  documentNamerow <- data.frame(names=factor())
}
proc.time()[3]-ptm[3]

#Corpus maken
corpus <- Corpus(VectorSource(documentNamesString))

