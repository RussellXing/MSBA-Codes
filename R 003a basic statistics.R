library(tidyverse)
households <- read_csv("D:/GWU/Courses/DNSC6211 Programming for Analytics/households.csv",col_names = TRUE,col_types = "iiiinnnnn")

library(moments)
attach(households)
par(mfrow=c(2,3))
hist(as.numeric(`First Income`), main = "First Income", xlab = "First Income", col = "blue", border = "pink", label = TRUE)
hist(as.numeric(`Second Income`), main = "Second Income", xlab = "Second Income", col = "blue", border = "pink", label = TRUE)
hist(as.numeric(`Monthly Payment`), main = "Monthly Payment", xlab = "Monthly Payment", col = "blue", border = "pink", label = TRUE)
hist(as.numeric(Utilities), main = "Utilities", xlab = "Utilities", col = "blue", border = "pink", label = TRUE)
hist(as.numeric(Debt), main = "Debt", xlab = "Debt", col = "blue", border = "pink", label = TRUE)
skew <- list(First_Income = skewness(as.numeric(`First Income`)),
             Second_Income = skewness(as.numeric(na.omit(`Second Income`))),
             Monthly_Payment = skewness(as.numeric(`Monthly Payment`)),
             Utilities = skewness(as.numeric(households$`Utilities`)),
             Debt = skewness(as.numeric(households$`Debt`)))
print(skew)

minmax_debt <- list(min = min(Debt), max = max(Debt))
print(paste("The minmum debt level for the households in the sample is ", minmax[[1]],
            "; The minmum debt level for the households in the sample is ", minmax[[2]],sep = ""))

quantile_debt <- quantile(Debt, c(0.25, 0.5, 0.75))

IQR_debt <- IQR(Debt, na.rm = TRUE)
quantile_norm <- c(qnorm(0.25, mean = mean(Debt), sd = sd(Debt)),
                   qnorm(0.5, mean = mean(Debt), sd = sd(Debt)),
                   qnorm(0.75, mean = mean(Debt), sd = sd(Debt)))
quantile <- rbind(quantile_debt, quantile_norm)
norm_IQR <- qnorm(0.75, mean = mean(Debt), sd = sd(Debt)) - qnorm(0.25, mean = mean(Debt), sd = sd(Debt))
print(paste("The interquantile range is",IQR_debt))
print(quantile)