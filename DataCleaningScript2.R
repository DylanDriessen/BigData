library('readr')

#Werkt, geen vreemde data

utf8Data <-read.table("Alfresco_EN_PDF__Persons_cln.utf8",
           sep=",",
           header=TRUE,
           encoding="UTF-8",
           stringsAsFactors=FALSE
)

cleanUtf8Data <- data.frame(id=numeric(), name=factor())

for (i in 1:NROW(utf8Data)) {
  id <- utf8Data[i,1]
  name <- utf8Data[i,2]
  row <- data.frame(id, name)
  
  if (!grepl("\\W", gsub("\\s", "", gsub('\\.', "", gsub('\\-', "", name))))) {
    cleanUtf8Data <- rbind(cleanUtf8Data, row)
  }
}

