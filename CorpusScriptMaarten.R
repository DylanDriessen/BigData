library(tm)
library(doParallel)

uniqueID <- unique(cleanUtf8Data$id)
documentNamesString <- NULL
idNameSet <- data.frame(names=factor())
documentNamerow <- data.frame(names=factor())


#Alleen voor eerste 50 id's
ptm <- proc.time()
registerDoParallel(cores=3)
for(i in 1:50){
  for(j in 1:nrow(cleanUtf8Data)){
    if(uniqueID[i] == cleanUtf8Data[j,1]){
      spaceGone <- gsub(" ", "SPACE", cleanUtf8Data[j,2])
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
tdm.sparse <- removeSparseTerms(tdm, sparse = 0.95)
tdmMatrix <- as.matrix(tdm.sparse)
tdmMatrix <- as.matrix(tdm)



#library(wordcloud)
#wordcloud(corpus, min.freq=10, colors=brewer.pal(8,"Set2"), random.order = FALSE, rot.per = 0.30)
#comparison.cloud(dtmMatrix, max.words = 100, random.order = FALSE)


#SKmeans test
library(skmeans)

hparty <- skmeans(tdm, 5, control = list(verbose = TRUE))



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
