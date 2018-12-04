library(magrittr)
library(plyr)
library(dplyr)

NewTable <- summarise(group_by(cleanUtf8Data,id,name),count =n())


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