library('readr')
library(parallel)
library(tm)


utf8Data <-read.table("Alfresco_EN_PDF__Persons_cln.utf8",
           sep=",",
           header=TRUE,
           encoding="UTF-8",
           stringsAsFactors=FALSE
)

cleanUtf8Data <<- data.frame(id=numeric(), name=factor())

#Cleaning with lapply and tm
ptm <- proc.time()
utf8Data$entity <- lapply(utf8Data$entity, function(x) tolower(x))
utf8Data$entity <- lapply(utf8Data$entity, function(x) gsub('\\.', "", gsub('\\-', "", gsub(" ", "_", x))))
cleanUtf8Data <- utf8Data
proc.time()[3]-ptm[3]
