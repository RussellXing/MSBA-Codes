library(dplyr)
library(ggplot2)

# read the dataset
path <- "D:/GWU/Courses/DNSC6211 Programming for Analytics/creditdata.csv"
creditdata <- read.csv(path, header = TRUE, na.string = "")

## Part A

# (i)

# split the data into training group and test group
train <- creditdata[1:floor(dim(creditdata)[1]/2),]
test <- creditdata[(floor(dim(creditdata)[1]/2)+1):dim(creditdata)[1],]

# (ii)

# examine if the data is clean
train[!complete.cases(train),]
sum(is.na(train))
#the data is clean

# (iii)

# make the factors 
creditdata$rating <- as.factor(creditdata$rating)
creditdata$homeown <- as.factor(creditdata$homeown)
creditdata$mstat <- as.factor(creditdata$mstat)
creditdata$rcds <- as.factor(creditdata$rcds)
creditdata$jtype <- as.factor(creditdata$jtype)

# decriptive analysis
table(creditdata$rating)
table(creditdata$homeown)
table(creditdata$mstat)
table(creditdata$rcds)
table(creditdata$jtype)

summary(creditdata$experience)
summary(creditdata$loandurn)
summary(creditdata$age)
summary(creditdata$explvl)
summary(creditdata$inc)
summary(creditdata$assts)
summary(creditdata$debt)
summary(creditdata$loanamount)
summary(creditdata$purchprice)

# explore
ggplot(creditdata, aes(rating)) + geom_bar() +
  scale_x_discrete(breaks=c("bad", "good"))

ggplot(creditdata, aes(experience, fill = rating)) + geom_bar()
ggplot(creditdata, aes(experience, fill = rating)) + geom_bar(position = "fill")

ggplot(creditdata, aes(homeown, fill = rating)) + geom_bar()
ggplot(creditdata, aes(homeown, fill = rating)) + geom_bar(position = "fill")

ggplot(creditdata, aes(loandurn, fill = rating)) + geom_bar()
ggplot(creditdata, aes(loandurn, fill = rating)) + geom_bar(position = "fill")

ggplot(creditdata, aes(age, fill = rating)) + geom_bar()
ggplot(creditdata, aes(age, fill = rating)) + geom_bar(position = "fill")

ggplot(creditdata, aes(mstat, fill = rating)) + geom_bar()
ggplot(creditdata, aes(mstat, fill = rating)) + geom_bar(position = "fill")

ggplot(creditdata, aes(rcds, fill = rating)) + geom_bar()
ggplot(creditdata, aes(rcds, fill = rating)) + geom_bar(position = "fill")

ggplot(creditdata, aes(jtype, fill = rating)) + geom_bar()
ggplot(creditdata, aes(jtype, fill = rating)) + geom_bar(position = "fill")

ggplot(creditdata, aes(explvl, fill = rating)) + geom_histogram(bins = 30)

ggplot(creditdata, aes(inc, fill = rating)) + geom_histogram(bins = 30)

ggplot(creditdata, aes(assts, fill = rating)) + geom_histogram(bins = 30)

ggplot(creditdata, aes(debt, fill = rating)) + geom_histogram(bins = 30)

ggplot(creditdata, aes(loanamount, fill = rating)) + geom_histogram(bins = 30)

ggplot(creditdata, aes(purchprice, fill = rating)) + geom_histogram(bins = 30)


## Part B

# (i)

# make the factors 
train$rating <- as.factor(train$rating)
train$homeown <- as.factor(train$homeown)
train$mstat <- as.factor(train$mstat)
train$rcds <- as.factor(train$rcds)
train$jtype <- as.factor(train$jtype)

# build the logistic regression model
model.logistic <- glm(formula = rating ~ ., family = binomial(link='logit'), data = train)
summary(model.logistic)


# (iii)

library(rpart)
library(rpart.plot)

model.tree <- rpart(rating ~ ., train, method = "class")
rpart.plot(model.tree, type=1, extra = 102)


## Part C

# (i)

# make the factors 
test$rating <- as.factor(test$rating)
test$homeown <- as.factor(test$homeown)
test$mstat <- as.factor(test$mstat)
test$rcds <- as.factor(test$rcds)
test$jtype <- as.factor(test$jtype)

# test the logistic model
model.logistic.fitted <- predict(model.logistic,test,type='response')
model.logistic.fitted <- ifelse(model.logistic.fitted > 0.5,"good","bad")
misClassificationError <- mean(model.logistic.fitted != test$rating)
print(paste('Accuracy',1-misClassificationError))

# print ROC
library(ROCR)
p <- predict(model.logistic, test, type="response")
pr <- prediction(p, test$rating)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)
abline(a=0, b= 1)

# calculate AUC
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc

# test the decision tree model
probs <- predict(model.tree, test, type = "prob")[,2]

# Create a prediction object: pred
pred <- prediction(probs, test$rating)


# plot ROC
perf <- performance(pred, "tpr" , "fpr")
plot(perf)
abline(a=0, b= 1)

# calculate AUC
auc <- performance(pred, measure = "auc")
auc <- auc@y.values[[1]]
auc
