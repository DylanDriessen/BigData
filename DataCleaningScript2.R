library('readr')

#Werkt, geen vreemde data

utf8Data <-read.table("Alfresco_EN_PDF__Persons_cln.utf8",
           sep=",",
           header=TRUE,
           encoding="UTF-8",
           stringsAsFactors=FALSE
)
