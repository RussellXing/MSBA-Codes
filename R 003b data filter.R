#read the csv file
library(tidyverse)
transaction <- read_csv("/home/linuxr/R Scripts/Week 3/SupermarketTransactions.csv",col_names = TRUE)#,col_types = "icicccicccccccnn")
attach(transaction)

#converse the date
transaction$`Purchase Date` <- as.Date(paste(substr(transaction$`Purchase Date`,1,nchar(transaction$`Purchase Date`)-4),substr(transaction$`Purchase Date`,nchar(transaction$`Purchase Date`)-1,nchar(transaction$`Purchase Date`)),sep = ""),"%m/%d/%y")

#All purchases made during January and February of 2008
subdata1 <- subset(transaction,`Purchase Date` >= "2008-01-01" & `Purchase Date` < "2009-01-01")
par(mfrow=c(1,2))
barplot(summary(as.factor(subdata1$`Units Sold`)),xlab = "Unit Sold",col = "blue",main = "barchart of unit sold")
hist(subdata1$Revenue,xlab = "Revenue",col = "blue",main = "histgram of revenue")

#All purchase made by married female homeowners
subdata2 <- subset(transaction, Gender == "F" & `Marital Status` == "M" & Homeowner == "Y")
par(mfrow=c(1,2))
barplot(summary(as.factor(subdata2$`Units Sold`)),xlab = "Unit Sold",col = "blue",main = "barchart of unit sold")
hist(subdata2$Revenue,xlab = "Revenue",col = "blue",main = "histgram of revenue")

#All purchases made in the state of California
subdata3 <- subset(transaction, `State or Province` == "CA")
par(mfrow=c(1,2))
barplot(summary(as.factor(subdata3$`Units Sold`)),xlab = "Unit Sold",col = "blue",main = "barchart of unit sold")
hist(subdata3$Revenue,xlab = "Revenue",col = "blue",main = "histgram of revenue")

#All purchases made in the Produce product department
subdata4 <- subset(transaction, `Product Department` == "Produce")
par(mfrow=c(1,2))
barplot(summary(as.factor(subdata4$`Units Sold`)),xlab = "Unit Sold",col = "blue",main = "barchart of unit sold")
hist(subdata4$Revenue,xlab = "Revenue",col = "blue",main = "histgram of revenue")