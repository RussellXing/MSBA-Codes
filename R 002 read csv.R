#Part C
#Question a
#read the csv file into dataframe "mydf"
mydf <- read.csv("/home/linuxr/R Scripts/Week 2/quizscores.csv",header = TRUE)

#Question b
#tabulate Degree by Sex
tb <- as.matrix(ftable(mydf$Sex, mydf$Degree))

#Calculate P(F)
P_F <- sum(subset(tb, rownames(tb) == "F"))/sum(tb)

#Calculate P(M)
P_M <- sum(subset(tb, rownames(tb) == "M"))/sum(tb)

#Calculate P(M and MBA)
P_M_MBA <- as.data.frame(subset(tb, rownames(tb) == "M"))$MBA/sum(tb)

#Calculate P(F and MS)
P_F_MS <- as.data.frame(subset(tb, rownames(tb) == "F"))$MS/sum(tb)

#Calculate P(F|MBA)
P_F__MBA <- (as.data.frame(subset(tb, rownames(tb) == "F"))$MBA/sum(tb))/(sum(as.data.frame(tb)$MBA)/sum(tb))

#Calculate P(MS|M)
P_MS__M <- (as.data.frame(subset(tb, rownames(tb) == "M"))$MS/sum(tb))/(sum(subset(tb, rownames(tb) == "M"))/sum(tb))

#Question c
#the average score across all six quizzes for males and females
#select male and female
mydf_m <- subset(mydf,Sex == "M")
mydf_f <- subset(mydf,Sex == "F")
#calculate the average
avg_m <- apply(mydf_m[,4:9],2,mean)
avg_f <- apply(mydf_f[,4:9],2,mean)

#Question d
#the average score across all six quizzes for the three sections
#select by section
mydf_A <- subset(mydf,Section == "A")
mydf_B <- subset(mydf,Section == "B")
mydf_C <- subset(mydf,Section == "C")
#calculate the average
avg_A <- apply(mydf_A[,4:9],2,mean)
avg_B <- apply(mydf_B[,4:9],2,mean)
avg_C <- apply(mydf_C[,4:9],2,mean)

#Question e
#the average score across all six quizzes for MBA and MS students
#select MBA and MS
mydf_MBA <- subset(mydf,Degree == "MBA")
mydf_MS <- subset(mydf,Degree == "MS")
#calculate the average
avg_MBA <- apply(mydf_MBA[,4:9],2,mean)
avg_MS <- apply(mydf_MS[,4:9],2,mean)