library(magrittr)
library(plyr)
library(dplyr)
library(slam)
library(skmeans)
library(Matrix)
#Source Data
FrequencyCountTable <- summarise(group_by(cleanUtf8Data,id,name),count = n())
FrequencyCountTable$id <- as.factor(FrequencyCountTable$id)
FrequencyCountTable$name <- as.factor(FrequencyCountTable$name)
FrequencyCountTable$id <- as.numeric(FrequencyCountTable$id)
FrequencyCountTable$name <- as.numeric(FrequencyCountTable$name)
summary(FrequencyCountTable)
#Simple triplet Matrix
i = c(FrequencyCountTable$name)
j = c(FrequencyCountTable$id)
v = c(FrequencyCountTable$count)
tripletMatrix = simple_triplet_matrix(i,j,v)

sparse <- sparseMatrix(i = as.numeric(tripletMatrix$i), j = as.numeric(tripletMatrix$j), x = as.numeric(as.character(tripletMatrix$v)), dims = dim(tripletMatrix), 
             dimnames = dimnames(tripletMatrix))

#skmeans
library(cluster)
library(fpc)
set.seed(1234)
test <- skmeans_xdist(tripletMatrix, y = NULL)
dataDist <- skmeans_xdist(tripletMatrix)
kfit <- skmeans(tripletMatrix, 4, method = NULL, m = 1, weights = 1, control = list())
cmd <- cmdscale(dataDist)
kfit$value

#plots
library(cluster)
plot(silhouette(kfit))
clusplot(sparse, kfit$cluster)
plotcluster(tripletMatrix, kfit$cluster)

groups <- levels(factor(kfit$cluster))
ordiplot(cmd, type = "n")
cols <- c("steelblue", "darkred", "darkgreen", "pink")
for(i in seq_along(groups)){
  points(cmd[factor(kfit$cluster) == groups[i], ], col = cols[i], pch = 16)
}

#tryout
library(cluster)
library(HSAUR)
km    <- kmeans(tripletMatrix,3)
dissE <- daisy(tripletMatrix) 
dE2   <- dissE^2
sk2   <- silhouette(km$cl, dE2)
plot(sk2)
