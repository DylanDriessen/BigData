library('readr')
setwd("R working directory/")

utf8Data <- read.csv(file = "Alfresco_EN_PDF__Persons_cln.utf8")
utf8Data <-read.table("Alfresco_EN_PDF__Persons_cln.utf8",
           sep=",",
           header=TRUE, 
           stringsAsFactors=FALSE
)
print(utf8Data)
