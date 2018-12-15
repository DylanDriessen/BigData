library('readr')
library(parallel)
library(tm)


utf8Data <-read.table("Alfresco_EN_PDF__Persons_cln.utf8",
           sep=",",
           header=TRUE,
           encoding="UTF-8",
           stringsAsFactors=FALSE
)

#Cleaning with lapply and tm
ptm <- proc.time()
utf8Data$entity <- lapply(utf8Data$entity, function(x) tolower(x))
utf8Data$entity <- lapply(utf8Data$entity, function (x)  sub("^\\s+", "", x))
utf8Data$entity <- lapply(utf8Data$entity, function(x) gsub('\\.', "", gsub('\\-', "", gsub(" ", "_", x))))

cleanUtf8Data <- transform(utf8Data, entity=unlist(utf8Data$entity))
proc.time()[3]-ptm[3]
names(cleanUtf8Data) <- c("id", "name")
