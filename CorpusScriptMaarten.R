library(tm)
library(slam)
library(skmeans)
library(plyr)
library(dplyr)
library(Matrix)

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

data.aggr$name <- as.factor(data.aggr$name)
data.aggr$id <- as.factor(data.aggr$id)

i <- c(data.aggr$id)
j <- c(data.aggr$name)
v <- c(data.aggr$count)
data.triplet <- simple_triplet_matrix(i,j,v)
data.triplet2 <- simple_triplet_matrix(j, i, v)

set.seed(2000)
data.cluster <- skmeans(data.triplet, 5)
data.cluster2 <- skmeans(data.triplet2, 5)

#Prepare data for JSON

#Names with cluster
data.names.cluster <- data.frame(cluster = data.cluster2$cluster, group=unique(data.aggr$name[order(data.aggr$name)]))

#Names with connected names and value
data.summ <- summarise(group_by(cleanUtf8Data, id, name))
data.links <- merge(data.summ, cleanUtf8Data, by="id")
data.links.freq <- summarise(group_by(data.links, name.x, name.y), count = n())



