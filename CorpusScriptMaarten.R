library(tm)
library(doParallel)
library(zoom)

uniqueID <- unique(cleanUtf8Data$id)
documentNamesString <- NULL
idNameSet <- data.frame(names=factor())
documentNamerow <- data.frame(names=factor())


#Alleen voor eerste 50 id's
ptm <- proc.time()
for(i in 1:50){
  for(j in 1:nrow(cleanUtf8Data)){
    if(uniqueID[i] == cleanUtf8Data[j,1]){
      spaceGone <- gsub(" ", "22", cleanUtf8Data[j,2])
      spaceGone <- data.frame(spaceGone)
      names(spaceGone) <- "names"
      idNameSet <- rbind(idNameSet, spaceGone)
    }
  }
  documentNamerow <- paste(idNameSet$names, collapse = " ")
  documentNamesString <- rbind(documentNamesString, documentNamerow)
}
proc.time()[3]-ptm[3]

#Corpus maken
corpus <- Corpus(VectorSource(documentNamesString))

#DTM maken
dtm <- DocumentTermMatrix(corpus)
dtmMatrix <- as.matrix(dtm)

#TDM maken
tdm <- TermDocumentMatrix(corpus)
tdmMatrix <- as.matrix(tdm)



#library(wordcloud)
#wordcloud(corpus, min.freq=10, colors=brewer.pal(8,"Set2"), random.order = FALSE, rot.per = 0.30)
#comparison.cloud(dtmMatrix, max.words = 100, random.order = FALSE)


#Hierarchical clustering
tdm.sparse <- removeSparseTerms(tdm, sparse = 0.95)
tdmSparseMatrix <- as.matrix(tdm.sparse)

distMatrix <- dist(scale(tdmSparseMatrix))
tdm.fit <- hclust(distMatrix, method = "ward.D")

plot(tdm.fit, cex=0.9, hang=-1, main = "Cluster Diagram")
rect.hclust(tdm.fit, k=5)
zm()
tdm.groups <- cutree(tdm.fit, k=5)


#SKmeans test
library(skmeans)
library(cluster)

skfit <- skmeans(tdmMatrix, 5)
clusplot(tdmMatrix, skfit$cluster)











#parLapply test
library(parallel)

parLapply(c1, 1:NROW(uniqueID), function(i, cleanUtf8Data, idNameSet, documentNamesString, documentNamerow, uniqueID){
  for(j in 1:nrow(cleanUtf8Data)){
    if(uniqueID[i] == cleanUtf8Data[j,1]){
      spaceGone <- gsub(" ", ".", cleanUtf8Data[j,2])
      spaceGone <- data.frame(spaceGone)
      names(spaceGone) <- "names"
      idNameSet <- rbind(idNameSet, spaceGone)
    }
  }
  documentNamerow <- paste(idNameSet$names, collapse = " ")
  documentNamesString <- rbind(documentNamesString, documentNamerow)
}, cleanUtf8Data, idNameSet, documentNamesString, documentNamerow, uniqueID)
