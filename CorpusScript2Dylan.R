library(magrittr)
library(plyr)
library(dplyr)
library(slam)
library(skmeans)
#Source Data
FrequencyCountTable <- summarise(group_by(cleanUtf8Data,id,name),count = n())
FrequencyCountTable$id <- as.factor(FrequencyCountTable$id)
FrequencyCountTable$name <- as.factor(FrequencyCountTable$name)
as.numeric(FrequencyCountTable$id)
as.numeric(FrequencyCountTable$name)
summary(FrequencyCountTable)
#Simple triplet Matrix
i = c(FrequencyCountTable$id)
j = c(FrequencyCountTable$name)
v = c(FrequencyCountTable$count)
xx = simple_triplet_matrix(i,j,v)

#skmeans
set.seed(1234)
skmeans_xdist(xx, y = NULL)
kfit <- skmeans(xx, 5)
kfit$value
require("cluster")
plot(silhouette(kfit))
library(cluster)
clusplot(xx, kfit$cluster, color=T, shade=T, labels=2, lines=0)
