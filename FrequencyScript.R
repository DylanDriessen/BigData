library(data.table)
library(tm)
library(wordcloud)
library(plyr)
library(igraph)
library(RCurl)
library(zoom)

dataSet <- utf8Data
names(dataSet) <- c("id", "name")
#Frequency matrix
matrix <- dcast(completeDataSet1, name.x~name.y)
matrix2 <- matrix[,1]
rownames(matrix) <- matrix[,1]
matrix$name.x <-NULL


#Frequency table
frequencyTable <- count(dataSet, 'name')
wordcloud(frequencyTable$name, frequencyTable$freq, min.freq=10)

#Netwerk graph test
g <- graph.adjacency(as.matrix(matrix), weighted=T, mode = "undirected")
g <- simplify(g)
V(g)$label <- V(g)$name
V(g)$degree <- degree(g)

set.seed(6696)
layout1 <- layout.fruchterman.reingold(g, niter=500)
V(g)$size=degree(g, mode = "in")/30
V(g)$color <- "orange"
V(g)$frame.color <- NA
E(g)$color <- rgb(.5, .5, 0, egam)
plot(g, layout=layout1, rescale = FALSE)
zm()


#Better layout
#V(g)$label.cex <- 2.2 * V(g)$degree / max(V(g)$degree)+ .2
egam <- (log(E(g)$weight)+.4) / max(log(E(g)$weight)+.4)
E(g)$width <- egam
# plot the graph in layout1
plot(g, layout=layout1)


