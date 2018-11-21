library(data.table)
library(tm)
library(wordcloud)
library(plyr)
library(igraph)
library(RCurl)

dataSet <- utf8Data
names(dataSet) <- c("id", "name")
#Frequency matrix
matrix <- dcast(completeDataSet1, name.x~name.y, fun.ag)
matrix2 <- matrix[,1]
rownames(matrix) <- matrix[,1]
matrix$name.x <-NULL

#Normalize
matrix.normalize <- apply(matrix, )

#Frequency table
frequencyTable <- count(dataSet, 'name')
wordcloud(frequencyTable$name, frequencyTable$freq, min.freq=10)

#Netwerk graph test
g <- graph.adjacency(as.matrix(matrix), weighted=T, mode = "undirected")
g <- simplify(g)

V(g)$label <- V(g)$name
V(g)$degree <- degree(g)

set.seed(3952)
layout1 <- layout.fruchterman.reingold(g)
plot(g, layout=layout1)