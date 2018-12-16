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
apt_test <- (ap_td[ap_td$document==363588,])

#Datacleaning
ap_td$term <- lapply(ap_td, function(x) tolower(x))