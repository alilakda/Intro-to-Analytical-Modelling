#Introduction to Analytics Modeling
#Homework 2 - Professor Sokol

rm(list = ls())
setwd("/Users/kunlelawal/Desktop/Masters/MSA/Classes/Fall2018/ISyE_6501/hw2")
data = read.table("credit_card_data.txt")

library(kernlab)
library(kknn)
library(data.table)

head(data)

#Question 3.1 - Cross Validation (a)

#model <- train.kknn(V11 ~ ., data = data, kmax = 61)

modelcv <- cv.kknn(V11 ~ ., data = data, kcv = 20)
head(modelcv[[1]])

cv = data.table(modelcv[[1]])
cv$yhat <- ifelse(cv$yhat < 0.49, 0, 1)
print('Cross Validation Accuracy')
print(table(cv$y == cv$yhat))
print(prop.table(table(cv$y == cv$yhat)))
mean(cv$y == cv$yhat) #calculating accuracy


#Question 3.1 - Training, Validation, Test Datasets (b)

#Dataset Creation

Sample <- sample(1:654, (654*0.6))
data.train <- data[Sample, ]
data.notrain <- data[-Sample, ]

Sample2 <- sample(1:197, (197*0.5))
data.validation <- (data.notrain[Sample2, ])

data.test <- data.notrain[-Sample2, ]

#Create Model 1 w/ Training Dataset

kmaxarray = list(11, 31, 71)

for(array in kmaxarray){

model <- train.kknn(V11 ~ ., data = data.train, kmax = array)
model

prediction <- predict(model, data.validation[, -11])
prediction

t_prediction <- ifelse(prediction < 0.49, 0, 1)

CM <- table(data.validation[, 11], t_prediction)
CM

accuracy <- (sum(diag(CM)))/sum(CM)
print(array)
accuracy
print(accuracy)

}

combineddata = rbind(data.train, data.validation)
model <- train.kknn(V11 ~ ., data = combineddata, kmax = 61)
model

prediction <- predict(model, data.test[, -11])
prediction

t_prediction <- ifelse(prediction < 0.49, 0, 1)

CM <- table(data.test[, 11], t_prediction)
CM

accuracy <- (sum(diag(CM)))/sum(CM)
print(array)
accuracy







