library(tm)
library(corpus)

uniqueID <- unique(cleanUtf8Data$id)
documentNamesString <- data.frame(nameString=String(),stringsAsFactors=FALSE)
idNameSet <- data.frame(names=factor())
documentNamerow <- data.frame(names=String(), stringsAsFactors=FALSE)

for(i in 1:10){
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
}

