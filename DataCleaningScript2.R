library('readr')
library(parallel)
library(tm)

nr_clusters <- detectCores() - 1
c1 <- makeCluster(nr_clusters)

utf8Data <-read.table("Alfresco_EN_PDF__Persons_cln.utf8",
           sep=",",
           header=TRUE,
           encoding="UTF-8",
           stringsAsFactors=FALSE
)

cleanUtf8Data <<- data.frame(id=numeric(), name=factor())

#With tm package
ptm <- proc.time()
for (i in 1:NROW(utf8Data)) {
  id <- utf8Data[i,1]
  name <- utf8Data[i,2]
  cName <- Corpus(VectorSource(name))
  cName <- tm_map(cName, content_transformer(tolower))
  cName <- tm_map(cName, removePunctuation)
  cName <- tm_map(cName, content_transformer(function(x) gsub(x, pattern = '\\-', replacement = "")))
  
  name <- content(cName)
  row <- data.frame(id, name)
  cleanUtf8Data <- rbind(cleanUtf8Data, row)
}
proc.time()[3]-ptm[3]













#Try with foreach DO NOT RUN
library(foreach)
library("doParallel")

registerDoParallel(cores=3)
cleanFuncton <- function(n, utf8Data, cleanUtf8Data){
  library(tm)
    id <- utf8Data[n,1]
    name <- utf8Data[n,2]
    cName <- Corpus(VectorSource(name))
    cName <- tm_map(cName, content_transformer(tolower))
    cName <- tm_map(cName, removePunctuation)
    cName <- tm_map(cName, content_transformer(function(x) gsub(x, pattern = '\\-', replacement = "")))
    
    name <- content(cName)
    row <- data.frame(id, name)
    cleanUtf8Data <<- rbind(cleanUtf8Data, row)
}
ptm <- proc.time()
foreach(n=1:NROW(utf8Data)) %dopar% cleanFuncton(n, utf8Data, cleanUtf8Data)
proc.time()[3]-ptm[3]


#Pogin tot parLapply DO NOT RUN
ptm <- proc.time()
parLapply(c1, 1:NROW(utf8Data), function(i, cleanUtf8Data, utf8Data){
  library(tm)
  id <- utf8Data[i,1]
  name <- utf8Data[i,2]
  
  cName <- Corpus(VectorSource(name))
  cName <- tm_map(cName, content_transformer(tolower))
  cName <- tm_map(cName, removePunctuation)
  cName <- tm_map(cName, content_transformer(function(x) gsub(x, pattern = '\\-', replacement = "")))
  
  name <- content(cName)
  row <- data.frame(id, name)
  cleanUtf8Data <- rbind(cleanUtf8Data, row)
}, cleanUtf8Data = cleanUtf8Data, utf8Data = utf8Data)
proc.time()[3]-ptm[3]


