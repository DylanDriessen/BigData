head(completeDataSet1)
library(cluster)

completeDataSet1.use = cars[,-c(1,2)]
medians = apply(completeDataSet1.use,2,median)
mads = apply(completeDataSet1.use,2,mad)
completeDataSet1.use = scale(completeDataSet1.use,center=medians,scale=mads)
