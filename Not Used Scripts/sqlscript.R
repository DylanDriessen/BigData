library(sqldf)
sqldf('SELECT name from cleanUtf8Data where id = 2069')
sqldf('SELECT name AS namex, name AS namey
        FROM cleanUtf8Data 
        GROUP BY ROLLUP (id, name)
        ')

df_postgres <- dbGetQuery(con, "SELECT * from public.test")

rollup(tripletMatrix, j = sum(value), by = c("name"))

sqldf('
      SELECT id, name, count(*)
      FROM cleanUtf8Data
      GROUP BY GROUPING SETS ((id,name),(id),())
      ORDER BY 1, 2')

#library(dplyr)
#rollup(cleanUtf8Data, j = sum(cleanUtf8Data$name), by = c(cleanUtf8Data$id,cleanUtf8Data$name))
#r = rollup(cleanUtf8Data, MARGIN = c("id","name"), FUN = sum, na.rm=TRUE)

uniqueName <- unique(cleanUtf8Data$name)
dataSet3 <- cleanUtf8Data
DF <- nameDataSetUnique
for(i in 2:NROW(uniqueName)){
  nameLoop <- i
  nameSetUnique <- unique(dataSet3[dataSet3$name==name,])
  nameDataSetUnique <- unique(merge(nameSetUnique, dataSet3, by="id"))
  #frequencyDataSetUnique <- count(nameDataSetUnique, nameDataSetUnique$name.y)
  DF <- rbind(DF, nameDataSetUnique)
  nameDataSetUnique <- data.frame(names=factor())
  i <- i + 1
}

dbWriteTable(con, "Xenit", 
             value = cleanUtf8Data, append = TRUE, row.names = FALSE)

test22 <- read(dtm.RDa)
test22 <-read.table("dtm.RDa")
