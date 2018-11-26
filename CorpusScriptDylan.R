library(tm)

corpus <- Corpus(VectorSource(dataSet2))
print(corpus)

inspect(corpus[1])

library(dplyr)
#proc.time geeft de berekentijd aan -> 0.77
#Moeten hier mss wel de eigennaam uit halen, zal al veel resultaten minder geven.
ptm <- proc.time()
completeDataSet4 <- inner_join(dataSet2, dataSet2, by="id")
proc.time()[3]-ptm[3]

#proc.time -> 25.19 + Error vector size! Merge absoluut niet gebruiken dus!
#ptm2 <- proc.time()
#completeDataSet1 <- merge(nameDataSet, idSet1, by="id")
#proc.time()[3]-ptm2[3]

#Zo de matrix maken duurt veel te lang, zeker over de hele completeDataSet4.. -> geen dcast gebruiken dus.
#ptm3 <- proc.time()
#matrix4 <- dcast(completeDataSet4, entity.x~entity.y)
#proc.time()[3]-ptm3[3]