library(tm)
library(slam)
library(skmeans)
library(plyr)
library(dplyr)
library(Matrix)
library(wordspace)
library(rjson)
library(jsonlite)

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
data.cluster2 <- skmeans(data.triplet2, 18)


#Prepare data for JSON#

#Names with cluster
data.names.cluster <- data.frame(group = data.cluster2$cluster, id=unique(data.aggr$name[order(data.aggr$name)]))

#Names with connected names and value
data.summ <- summarise(group_by(cleanUtf8Data, id, name))
data.links <- merge(data.summ, cleanUtf8Data, by="id")
data.links.freq <- summarise(group_by(data.links, name.x, name.y), count = n())
names(data.links.freq) <-  c("source", "target", "value")

#Remove persons who don't often work together
data.links.freqMod <- data.links.freq[data.links.freq$value>10,]
data.links.freqMod$value <- lapply(data.links.freqMod$value, function(x){
  if(x>30){
    x=30
    return(x)
  }
  return(x)
})
data.names.cluster.relevant <- data.names.cluster[data.names.cluster$id %in% data.links.freqMod$source,]

#Write to JSON
data.json.list <- list(data.names.cluster.relevant, data.links.freqMod)
names(data.json.list) <-  c("nodes", "links")
data.json <- toJSON(data.json.list, dataframe = c("rows", "columns", "values"), pretty = TRUE)

write(data.json, "data.json")


#Cluster and most used words#

#Specifiq tabel with cluster and relevant docs
clusterNumber <- 3

clusterDocs <- merge(data.names.cluster, data.aggr, by.x = c('id'), c('name'))
clusterDocs$count <- NULL
clusterDocs$id <- NULL
names(clusterDocs) <- c('cluster', 'id')

clusterDocs.freq <- summarise(group_by(clusterDocs, cluster, id), freq=n())
clusterDocs.specific <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber,]

#Words for specific cluster
clusterWords <- merge(clusterDocs.specific, dtmTable, by.x = c("id"), by.y = c("document"))
clusterWords$freq <- NULL
clusterWords$id <- NULL


