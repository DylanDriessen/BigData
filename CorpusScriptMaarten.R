library(tm)
library(doParallel)
library(slam)
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

#Cluster skmeans
data.aggr <- summarise(group_by(cleanUtf8Data, id, name), count = n())
data.triplet <- simple_triplet_matrix(data.aggr$id, data.aggr$name, data.aggr)