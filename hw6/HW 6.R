#Mihir Tulpule, Ali Mujtaba, Anu Rana, Kunle Lawal
#ISYE 6501
#Homework 6

rm(list=ls())
setwd("/Users/MihirT/Desktop")

crime_data <- read.table("uscrime.txt", header = TRUE)
head(crime_data)

crimemod <- lm(Crime ~ ., data = crime_data)
summary(crimemod)

crimepca <- prcomp(crime_data[,-16], scale.=TRUE, center = TRUE)
crimepca

summary(crimepca)

variance <- crimepca$sdev^2

prop_variance <- variance/sum(variance)
plot(prop_variance,
     xlab = "Principal Component",
     ylab = "Proportional Variance",
     ylim = c(0,1) , type= "b")

screeplot(crimepca, main = "Scree Plot", type = "line")
abline(h=1, col="blue")

k = 5
comb_crime <- cbind(crimepca$x[,1:k],crime_data[,16])

crimemod2 <- lm(V6~., data = as.data.frame(comb_crime))
summary(crimemod2)


b0 <- crimemod2$coefficients[1]
#below we pull out our model coefficients, and make the Beta vector
beta_pca <- crimemod2$coefficients[2:(k+1)]
#now multply the coefficients by our rotated matrix, A to create alpha vector
beta_original <- crimepca$rotation[,1:k] %*% beta_pca
#we recover our original alpha values by dividing the alpha vector by sigma
#and our original beta by subtracting from the intercept the sum of (alpha*mu)/sigma
mu <- sapply(crime_data[,1:15],mean)
stdev <- sapply(crime_data[,1:15],sd)
origbeta <- beta_original/stdev
origBeta0 <- b0 - sum(beta_original*mu / stdev)

b0
beta_pca
beta_original
mu
stdev
origbeta
origBeta0

summary(crimemod)

new_data <- data.frame(M= 14.0, So = 0, Ed = 10.0, Po1 = 12.0, Po2 = 15.5,
                       LF = 0.640, M.F = 94.0, Pop = 150, NW = 1.1, U1 = 0.120, U2 = 3.6, Wealth = 3200, Ineq = 20.1, Prob = 0.040,Time = 39.0)

pred_df <- data.frame(predict(crimepca, new_data)) 
head(pred_df)

pred <- predict(crimemod2, pred_df, interval = 'prediction')
pred


