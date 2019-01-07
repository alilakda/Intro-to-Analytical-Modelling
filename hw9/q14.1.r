rm(list = ls())
library(data.table)
setwd("Google Drive/isye6501modelling/isye6501homeworks/hw9")
data = read.table("breast-cancer-wisconsin.data.txt",sep = ",", header = FALSE)

data1 <- copy(data)

data1[data1 == "?"] <- NA
data2 <- na.omit(data1)
#locate the NA's
is.na(data1)
#how many missings per variable?
colSums(is.na(data1))


data2[,7]

# We have 16 NA's we can use similar methodology for mode and mean 
meandata = mean(as.numeric(data2[,7])) 
data1[,7] <- sapply(data1[, 7], as.numeric)
data1[,7]
data1[is.na(data1[, 7]), 7] <- meandata

data3 <- copy(data)

getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

mode <- getmode(data3[,7])
data3[data3 == "?"] <- NA
data3[,7] <- sapply(data3[, 7], as.numeric)
data3[is.na(data3[, 7]), 7] <- mode
data3[,7]


library(mice)
data4 <- copy(data)
data4[data4 == "?"] <- NA
data4[,7] <- sapply(data4[, 7], as.numeric)

# Deterministic regression imputation via mice
imp <- mice(data4, method = "norm.predict", m = 1)

# Store data
data_imp <- complete(imp)
data_imp

data5 <- copy(data)
data5[data5 == "?"] <- NA
data5[,7] <- sapply(data5[, 7], as.numeric)


# Deterministic regression imputation via mice with pertubation 
imp1 <- mice(data5, method = "norm.nob", m = 1)

# Store data
data_imp1 <- complete(imp1)
data_imp1


library(kknn)

knn_process <- function(data1){



kmax <- 30

# use train.kknn for leave-one-out cross-validation up to k=kmax

model <- train.kknn(V11~.,data1,kmax=kmax,scale=TRUE)

# create array of prediction qualities

accuracy <- rep(0,kmax)

# calculate prediction qualities

for (k in 1:kmax) {
  predicted <- as.integer(fitted(model)[[k]][1:nrow(data1)] + 0.5) # round off to 0 or 1
  accuracy[k] <- mean(predicted == data$V11)
}

# show accuracies

print(accuracy)

}
#Mean
knn_process(data1)
#Removed 
knn_process(data2)
#Mode
knn_process(data3)
#Regression
knn_process(data_imp)
#Regression with perturbation
knn_process(data_imp1)
  