library(magrittr)
library(plyr)
library(dplyr)
library(slam)
library(skmeans)
#Source Data
NewTable <- summarise(group_by(cleanUtf8Data,id,name),count = n())
NewTable$id <- as.factor(NewTable$id)
NewTable$name <- as.factor(NewTable$name)
as.numeric(NewTable$id)
as.numeric(NewTable$name)

#Simple triplet Matrix
New2Table <- data.frame(unclass(NewTable))
#library(SnowballC)
i = c(NewTable$id)
j = c(NewTable$name)
v = c(NewTable$count)
xx = simple_triplet_matrix(i,j,v)
xx

q <- as.numeric(levels(New2Table$id))


#skmeans
set.seed(1234)
skmeans <- skmeans(xx, 5)

#Overbodige nest momenteel
NewTable <- cleanUtf8Data %>%
  count(NewTable$id, NewTable$name) %>%
  ungroup()
total_entities <- NewTable %>% 
  group_by(NewTable$id) %>% 
  summarize(total = sum(n))
NewTable <- left_join(NewTable, total_entities)
NewTable
CountTable <- count(cleanUtf8Data, c(cleanUtf8Data$id, cleanUtf8Data$name))
cleanUtf8Data %>% group_by(id, name) %>% count(cleanUtf8Data, c('id', 'name'))