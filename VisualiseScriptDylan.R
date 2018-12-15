# install.packages("RPostgreSQL")
require("RPostgreSQL")

# create a connection
# save the password that we can "hide" it as best as we can by collapsing it
pw <- {
  ""
}

# loads the PostgreSQL driver
drv <- dbDriver("PostgreSQL")
# creates a connection to the postgres database
# note that "con" will be used later in each connection to the database
con <- dbConnect(drv, dbname = "postgres",
                 host = "localhost", port = 5432,
                 user = "postgres", password = pw)
rm(pw) # removes the password

# check for the cartable
dbExistsTable(con, "cartable")
# TRUE

#Try This Maarten
library(dplyr)
library(igraph)
library(magrittr)
library(visNetwork)
library(DiagrammeR)
library(data.table)
mydata <- data.links.freq
graph <- graph.data.frame(mydata, directed=F)
E(graph)$weight <- 1
graph <- simplify(graph, edge.attr.comb=list(weight = "sum", transaction_amount = "sum", function(x)length(x)))
networks <- clusters(as.undirected(graph))
V(graph)$network <- networks$membership
nodes <- get.data.frame(graph, what="vertices")
dt <- data.table(merge(mydata, nodes, by.x=c("name.y"), by.y=c("name")))

nodes <- data.frame(id = nodes$name, title = nodes$name, group = nodes$network)
nodes <- nodes[order(nodes$id, decreasing = F),]

edges <- get.data.frame(graph, what="edges")[1:2]

library(visNetwork)
network <- visNetwork(nodes, edges) %>%
  visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE)%>%
  visGroups(groupname = "1", color = "maroon") 

visSave(network, file = "network.html", background = "white", selfcontained = FALSE)
