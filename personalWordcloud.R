library(wordcloud)
library(wordcloud2)


personName <- 'adolf_hitler'
personIdList <- cleanUtf8Data[cleanUtf8Data$name==personName, ]
personWordList <- merge(personIdList, dtmTable, by.x=c('id'), by.y=c('document'))
personWordList$id <- NULL
personWordList$name <- NULL
personWordList$term <- as.character(personWordList$term)

termFrequency <- aggregate(count ~ term, personWordList, sum)

#Wordcloud van termen
par(mfrow=c(1,1))
pal = brewer.pal(8,"Dark2")
set.seed(1234)
png("wordcloudPersonal.png", width=1280,height=800)
wordcloud(termFrequency$term, termFrequency$count, min.freq=25,scale=c(8, 0.5),
          max.words=Inf, random.order=FALSE, rot.per=.15,
          colors = pal)