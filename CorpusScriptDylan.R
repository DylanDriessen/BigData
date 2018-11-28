library(tm)
library(data.table)
library(doParallel)
library(dplyr)

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

#proc.time -> 25.19 + Error vector size! Merge absoluut niet gebruiken dus!
#ptm2 <- proc.time()
#completeDataSet1 <- merge(nameDataSet, idSet1, by="id")
#proc.time()[3]-ptm2[3]

#Zo de matrix maken duurt veel te lang, zeker over de hele completeDataSet4.. -> geen dcast gebruiken dus.
#ptm3 <- proc.time()
#matrix4 <- dcast(sampleDataSet, entity.x~entity.y, fill=0)[-1]
#proc.time()[3]-ptm3[3]

