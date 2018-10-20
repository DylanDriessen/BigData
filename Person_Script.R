#install.packages("data.table", type="source", dependencies=TRUE)
#install.packages("qdap")
#install.packages("readxl")
#install.packages("xlsx")
library(data.table)
library(dplyr)
library(qdap)
library(readxl)
library(xlsx)

getwd()
#persondata = read.csv("Alfresco.csv")
my_data = read_excel("Alfresco.xlsx")
#data.table(persondata)
my_data
data.table(my_data)
colsplit2df(my_data,, c("ID", "Identity"), ",")
#Mss is proberen me gewoon colsplit, echt een hel

