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

set.seed(2000)
data.cluster <- skmeans(data.triplet, 5)


#Plotting
test <- i
test <- cbind(test, j)

plot(test, col = data.cluster$cluster)

test2 <- j
test2 <- cbind(test2, v)
plot(test2, col = data.cluster$cluster)
