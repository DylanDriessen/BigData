dtm.rda <- load(file = "dtm.RDa")
library(tm)
dtm
d <- 27 # Selecteer document 2069 -> in doc2index staat referentie
m <- as.matrix(dtm[d,])
termvector <- as.matrix(dtm[d,m>0])      # Resultaat als matrix
termvector <- as.data.frame(termvector)  # Resultaat als dataframe
View(termvector)
View(doc2index)

library(dplyr)
library(tidytext)

ap_td <- tidy(dtm)

#Cluster's
clusterNumber1 <- 1
clusterDocs.specific1 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber1,]
clusterNumber2 <- 2
clusterDocs.specific2 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber2,]
clusterNumber3 <- 3
clusterDocs.specific3 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber3,]
clusterNumber4 <- 4
clusterDocs.specific4 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber4,]
clusterNumber5 <- 5
clusterDocs.specific5 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber5,]
clusterNumber6 <- 6
clusterDocs.specific6 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber6,]
clusterNumber7 <- 7
clusterDocs.specific7 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber7,]
clusterNumber8 <- 8
clusterDocs.specific8 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber8,]
clusterNumber9 <- 9
clusterDocs.specific9 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber9,]
clusterNumber10 <- 10
clusterDocs.specific10 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber10,]
clusterNumber11 <- 11
clusterDocs.specific11 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber11,]
clusterNumber12 <- 12
clusterDocs.specific12 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber12,]
clusterNumber13 <- 13
clusterDocs.specific13 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber13,]
clusterNumber14 <- 14
clusterDocs.specific14 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber14,]
clusterNumber15 <- 15
clusterDocs.specific15 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber15,]
clusterNumber16 <- 16
clusterDocs.specific16 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber16,]
clusterNumber17 <- 17
clusterDocs.specific17 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber17,]
clusterNumber18 <- 18
clusterDocs.specific18 <- clusterDocs.freq[clusterDocs.freq$cluster%in%clusterNumber18,]
