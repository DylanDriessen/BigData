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
distance <- netdistance(matrix)

<<<<<<< HEAD
#Normalize
#matrix.normalize <- apply(matrix, )
=======
>>>>>>> d990ef25feef60b4aaab9353a57edb36182382cf

#Frequency table
library(wordcloud)
library(viridis)
pal = brewer.pal(9,"BuGn")
frequencyTable <- count(dataSet, 'name')
wordcloud(frequencyTable$name, frequencyTable$freq, min.freq=10)

#Netwerk graph test
g <- graph.adjacency(as.matrix(matrix), weighted=T, mode = "undirected")
g <- simplify(g)
V(g)$label <- V(g)$name
V(g)$degree <- degree(g)

<<<<<<< HEAD
set.seed(4)
layout1 <- layout.fruchterman.reingold(g)

V(g)$label.cex <- 2.2 * V(g)$degree / max(V(g)$degree)+ .2
V(g)$label.color <- rgb(0, 0, .2, .8)
=======
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
<<<<<<< HEAD
#zoom
zm()
=======


>>>>>>> d990ef25feef60b4aaab9353a57edb36182382cf
