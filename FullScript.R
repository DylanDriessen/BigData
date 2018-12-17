library('readr')
library(parallel)
library(tm)
library(tidytext)

#Cleaning Data
utf8Data <-read.table("Alfresco_EN_PDF__Persons_cln.utf8",
                      sep=",",
                      header=TRUE,
                      encoding="UTF-8",
                      stringsAsFactors=FALSE
)

dtm.rda <- load(file = "dtm.RDa")
dtmTable <- tidy(dtm)
dtmTable.toRemove <- data.frame(term=unique(dtmTable$term[grep('^.$', dtmTable$term, perl = TRUE)]))
dtmTable <- dtmTable[!dtmTable$term %in% dtmTable.toRemove$term,]
dtmTable$term <- lapply(dtmTable$term, function(x) tolower(x))
dtmTable <- dtmTable[!dtmTable$term %in% stop_words$word,]

#Cleaning with lapply and tm
ptm <- proc.time()
utf8Data$entity <- lapply(utf8Data$entity, function(x) tolower(x))
utf8Data$entity <- lapply(utf8Data$entity, function (x)  sub("^\\s+", "", x))
utf8Data$entity <- lapply(utf8Data$entity, function(x) gsub('\\.', "", gsub('\\-', "", gsub(" ", "_", x))))

cleanUtf8Data <- transform(utf8Data, entity=unlist(utf8Data$entity))
proc.time()[3]-ptm[3]
names(cleanUtf8Data) <- c("id", "name")

#WORDCLOUDS
library(stats)
library(plyr)
library(wordcloud)
library(wordcloud2)
library(viridis)
library(dplyr)

dataSet2 <- cleanUtf8Data
#Te kiezen naam
name <- 'adolf_hitler'

#Geeft alle unieke ID's van de naam ".."
nameSetUnique <- unique(dataSet2[dataSet2$name==name,])

#Geeft alle unieke namen van personen verbonden met persoon hierboven in nameSet PER id
nameDataSetUnique <- unique(merge(nameSetUnique, dataSet2, by="id"))

#Tel frequentie van naam
library(plyr)
frequencyDataSetUnique <- count(nameDataSetUnique, nameDataSetUnique$name.y)

#Wordcloud
par(mfrow=c(1,1))
pal = brewer.pal(8,"Dark2")
set.seed(1234)
png("wordcloudUnique.png", width=1280,height=800)
wordcloud(frequencyDataSetUnique$`nameDataSetUnique$name.y`, frequencyDataSetUnique$n,scale=c(8, 2),
          max.words=Inf, random.order=FALSE, rot.per=.15,
          colors = pal)
dev.off()

#Nu alles geven, dus niet uniek

#Geeft alle ID's van de naam ".."
nameSet <- (dataSet2[dataSet2$name==name,])

#Geeft alle namen van personen verbonden met persoon hierboven in nameSet PER id
nameDataSet <- (merge(nameSet, dataSet2, by="id"))

#Tel frequentie van naam
frequencyDataSet2 <- count(nameDataSet, nameDataSet$name.y)

#Wordcloud
par(mfrow=c(1,1))
pal = brewer.pal(8,"Dark2")
set.seed(1234)
png("wordcloud.png", width=1280,height=800)
wordcloud(frequencyDataSet2$`nameDataSet$name.y`, frequencyDataSet2$n, min.freq=2,scale=c(8, 2),
          max.words=Inf, random.order=FALSE, rot.per=.15,
          colors = pal)
dev.off()

#SCRIPT MAARTEN

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
data.cluster2 <- skmeans(data.triplet2, 34)

dim(data.cluster2)
hparty <- skmeans(data.cluster2, 5, control = list(verbose = TRUE))
hparty$value
class_ids <- attr(data.cluster2, "rclass")
table(class_ids, hparty$cluster)
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
clusterNumber <- 1
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

#Set terms to character
clusterWords$term <- as.character(clusterWords$term)

#Frequency words in specific cluster (without excisting value)
countWords <- count(clusterWords, clusterWords$term)
count2Words <- merge(clusterWords, countWords, by.x = c('term'), c('clusterWords$term'))

#Alle waarden opgeteld over de verschillende documenten
library(data.table)
DT <- data.table(clusterWords)
count2Words <- DT[ , .(Totalcount = sum(count)), by = .(term)]
summary(count2Words)

#Wordcloud van termen
par(mfrow=c(1,1))
pal = brewer.pal(8,"Dark2")
set.seed(1234)
png("wordcloud.png", width=1280,height=800)
wordcloud(count2Words$term, count2Words$Totalcount, min.freq=1000,scale=c(4, 0.5),
          max.words=Inf, random.order=FALSE, rot.per=.15,
          colors = pal)
dev.off()

#Wordcloud specifieke persoon
personName <- 'ian_van_roosmalen'
personIdList <- cleanUtf8Data[cleanUtf8Data$name==personName, ]
personWordList <- merge(personIdList, dtmTable, by.x=c('id'), by.y=c('document'))
personWordList$id <- NULL
personWordList$name <- NULL
personWordList$term <- as.character(personWordList$term)

termFrequency <- aggregate(count ~ term, personWordList, sum)

#Wordcloud van termen
par(mfrow=c(1,1))
pal = brewer.pal(8,"Dark2")
set.seed(1234)
png("wordcloudPersonal.png", width=1280,height=800)
wordcloud(termFrequency$term, termFrequency$count, min.freq=1000,scale=c(8, 0.5),
          max.words=Inf, random.order=FALSE, rot.per=.15,
          colors = pal)
dev.off()