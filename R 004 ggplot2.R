library(dplyr)
library(tibble)
library(xtable)
library(ggplot2)

## Part A

# Read the data
# You download this file from https://www.kaggle.com/ludobenistant/hr-analytics
# and use your own path 
mydf <- read.csv("C:/Users/lx/Desktop/Guangyu/HR_comma_sep.csv")

# get rows and columns
dim.data.frame(mydf)

# explore the data structure
str(mydf)

# Correlate all the numeric fields
xtable(cor(subset(mydf, select = -c(sales, salary))))


# Create a correlation heat map
library(reshape2)
melted_cormat <- melt(cor(subset(mydf, select = -c(sales, salary))))
head(melted_cormat)

g <- ggplot(data = melted_cormat, aes(x=Var1, y=Var2, fill=value)) + 
  geom_raster()
g <- g + theme(axis.text.x = element_text(angle = 90, hjust = 1))
g


# Develop a 3-way table
mydf$status <- ifelse(mydf$left == 1, "Left", "Stay")
table(mydf$status,  mydf$salary, mydf$sales)


# Employees who leave by department
ggplot(mydf[ which(mydf$status=='Left'),], 
       aes(x = sales, fill = status)) + geom_bar() + guides(fill=FALSE) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) 

# Complete this for employees who stay in the company by department
ggplot(mydf[ which(mydf$status=='Stay'),], 
       aes(x = sales, fill = status)) + geom_bar() + guides(fill = FALSE) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 


## Part B

# Complete this for employees who leave the company by salary level
ggplot(mydf[mydf$status=='Left',], 
       aes(x = salary, fill = status)) + geom_bar() + guides(fill = FALSE)

# Complete this for employees who stay in the company by salary level 
ggplot(mydf[mydf$status=='Stay',], 
       aes(x = salary, fill = status)) + geom_bar() + guides(fill = FALSE)

# Make a chart for number of employees who leave the company by time spent in the company
# faceted by salary level AND department
mydf2 <- mydf
colnames(mydf2)[9] <- "dept"
colnames(mydf2)[5] <- "year"
ggplot(mydf2[ which(mydf$status=='Left'),], 
       aes(x = year, fill = status)) + geom_bar() + guides(fill = FALSE) +
       facet_grid(salary ~ dept, scales = "free")

# Make a chart for number of employees who stay in the company by time spent in the company 
# faceted by salary level AND department
ggplot(mydf2[ which(mydf$status=='Stay'),], 
       aes(x = year, fill = status)) + geom_bar() + guides(fill = FALSE) +
       facet_grid(salary ~ dept, scales = "free") + 
       theme(axis.text.x = element_text(angle = 60, hjust = 1)) 


## Part C
# Draw a bar plot of how many years did employees stay in the company before leaving
# Year stayed in the company is the x axis
ggplot(mydf2[mydf2$status=='Left',], 
       aes(x = year, fill = status)) + geom_bar() + guides(fill = FALSE)


# Draw a bar plot of how many years did employees stay in the company before leaving
# by department
# Year stayed in the company is the x axis
ggplot(mydf2[mydf2$status=='Left',], 
       aes(x = year, fill = status)) + geom_bar() + guides(fill = FALSE) +
       facet_grid(dept ~ ., scales = "free")


# Draw a bar plot of how many years did employees stay in the company before leaving
# by salary level
# Year stayed in the company is the x axis
ggplot(mydf2[mydf2$status=='Left',], 
       aes(x = year, fill = status)) + geom_bar() + guides(fill = FALSE) +
       facet_grid(salary ~ ., scales = "free")


