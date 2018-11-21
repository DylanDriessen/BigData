library(data.table)

matrix <- dcast(completeDataSet1, name.x~name.y)

test <- apply(matrix, 2, normalize)
