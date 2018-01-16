#myAvg

myAvg <- function(vector){
  Avg <- mean(vector)         #compute average
  return(Avg)                 #return average
}


#mySD

mySD <- function(vector){
  SD <- sd(vector)            #compute Std Dev
  return(SD)                  #return Std Dev
}


#myRange

myRange <- function(vector){
  range <- max(vector)-min(vector)      #compute range, calculated as Max - Min
  return(range)                         #return range
}


#CardioGoodnessFit

CGF <- read.csv("/home/linuxr/R Scripts/Week 1/CardioGoodnessFit.csv",header = TRUE)    #read csv file

#build function
stats <- function(x,y){
  income_Avg <- myAvg(x)                #calculate statistics
  income_SD <- mySD(x)
  income_Range <- myRange(x)
  income <- paste("Income (Average, SD, Range) = ",income_Avg,", ",income_SD,", ",income_Range,sep = "")
  mile_Avg <- myAvg(y)
  mile_SD <- mySD(y)
  mile_Range <- myRange(y)              #calculate statistics
  miles <- paste("Miles (Average, SD, Range) = ",mile_Avg,", ",mile_SD,", ",mile_Range,sep = "")   #output results
  results <- list(income,miles)
  return(results)
}

stats(CGF[,8],CGF[,9])                  #output the results