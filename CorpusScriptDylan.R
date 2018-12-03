library(tm)
library(data.table)
library(doParallel)
library(dplyr)
library(netmeta)
library(proxy)
library(skmeans)
library(stats)
library(cluster)

#corpus <- Corpus(VectorSource(dataSet2))
#print(corpus)
#inspect(corpus[1])

library(dplyr)
#proc.time geeft de berekentijd aan -> 0.77
#Moeten hier mss wel de eigennaam uit halen, zal al veel resultaten minder geven.
ptm <- proc.time()
completeDataSet4 <- inner_join(dataSet2, dataSet2, by="id")
proc.time()[3]-ptm[3]
View(completeDataSet4)

#Random Subset
sampleDataSet <- sample_n(completeDataSet4, 1000000)
sampleDataSet <- setDT(sampleDataSet)

sampleDataSet3 <- sample_n(completeDataSet4, 10)
sampleDataSet3 <- setDT(sampleDataSet3)

#doParallel
registerDoParallel(cores=3)
ptm3 <- proc.time()
matrix4 <- dcast(sampleDataSet, entity.x~entity.y)
proc.time()[3]-ptm3[3]

registerDoParallel(cores=3)
View(matrix4)

#sparceMatrix
library(Matrix)
ptm5 <- proc.time()
UIMatrix <- sparseMatrix(i = sampleDataSet$entity.x,
                        j = sampleDataSet$entity.y,
                         x = NULL)
proc.time()[3]-ptm5[3]

registerDoParallel(cores=3)
ptm5 <- proc.time()
trial<-dcast(completeDataSet4, entity.x ~ entity.y, fill = 0)
proc.time()[3]-ptm5[3]

ptm5 <- proc.time()
trial2<-dcast(sampleDataSet3, entity.x ~ entity.y)
trial2$entity.x <-NULL
distance <- netdistance(trial2)
proc.time()[3]-ptm5[3]

#kmeans
#sillhouettes is proberen gebruiken
#k means algorithm, 2 clusters, 100 starting configurations
library(proxy)
t <- dist(as.matrix(tdmMatrix), method="cosine")
print(t)
d <- dist(as.matrix(dtmMatrix))
kfit <- kmeans(tdmMatrix, 5, nstart = 100)
kfit2 <- kmeans(d, 5, nstart = 100)
#plot – need library cluster
library(cluster)
clusplot(as.matrix(tdm), kfit$cluster, color=T, shade=T, labels=2, lines=0)
zm()
library(cluster)
clusplot(as.matrix(d), kfit2$cluster, color=T, shade=T, labels=2, lines=0)
zm()

library(fpc)
plotcluster(as.matrix(d), kfit2$cluster)


#Verder op maarten zijn script
corpusDylan <- tm::Corpus(tm::VectorSource(documentNamesString))
corpus.cleaned <- tm::tm_map(corpusDylan, tm::stripWhitespace)  
tdm <- tm::DocumentTermMatrix(corpus.cleaned) 
tdm.tfidf <- tm::weightTfIdf(tdm)
tdm.tfidf <- tm::removeSparseTerms(tdm.tfidf, 0.999) 
tfidf.matrix <- as.matrix(tdm.tfidf) 
dist.matrix = proxy::dist(tfidf.matrix, method = "cosine")
clustering.kmeans <- kmeans(tfidf.matrix, 5)

master.cluster <- clustering.kmeans$cluster 
names(stacked.clustering) <- 1:length(master.cluster) 

points <- cmdscale(dist.matrix, k = 4) 
previous.par <- par(mfrow=c(2,2), mar = rep(1.5, 4)) 

plot(points, main = 'K-Means clustering', col = as.factor(master.cluster), 
     mai = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), 
     xaxt = 'n', yaxt = 'n', xlab = '', ylab = '') 

#proc.time -> 25.19 + Error vector size! Merge absoluut niet gebruiken dus!
#ptm2 <- proc.time()
#completeDataSet1 <- merge(nameDataSet, idSet1, by="id")
#proc.time()[3]-ptm2[3]

#Zo de matrix maken duurt veel te lang, zeker over de hele completeDataSet4.. -> geen dcast gebruiken dus.
#ptm3 <- proc.time()
#matrix4 <- dcast(sampleDataSet, entity.x~entity.y, fill=0)[-1]
#proc.time()[3]-ptm3[3]

tdm1 <- DocumentTermMatrix(corpus)
m <- as.matrix(tdm1)
dti <- DocumentTermMatrix(corpus, control = list(weighting = weightTfIdf()))
m1 <- as.matrix(dtmi)
dtms <- removeSparseTerms(dtmi, 0.79)
m2 <- as.matrix(dtms)
m3 <- 1 - crossprod_simple_triplet_matrix(dtms)/(sqrt(col_sums(dtms^2) %*% t(col_sums(dtms^2))))
km.res <- eclust(m3, "kmeans", k = 3, nstart = 100, graph = FALSE)

