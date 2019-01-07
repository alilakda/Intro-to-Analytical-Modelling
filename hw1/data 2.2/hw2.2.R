#reading the data 
credit_card_data <- read.table("credit_card_data.txt", header = FALSE)
head(credit_card_data)
require("kernlab")
credit_card_data <- as.matrix(credit_card_data)
# applying the kvsm model with C = 100 
model <- ksvm(credit_card_data[,1:10],credit_card_data[,11],type="C-svc",kernel="vanilladot",C=100,scaled=TRUE)
summary(model)
a <- colSums(model@xmatrix[[1]] * model@coef[[1]])
a
a0 <- -model@b
a0
pred <- predict(model,credit_card_data[,1:10])
pred
sum(pred == credit_card_data[,11])/ nrow(credit_card_data)

#exploring other kernels for kvsm - such as rbfdot
model2 <- ksvm(credit_card_data[,1:10],credit_card_data[,11],type="C-svc",kernel="rbfdot",C=100,scaled=TRUE)
a <- colSums(model2@xmatrix[[1]] * model2@coef[[1]])
a
a0 <- -model2@b
a0
pred2 <- predict(model2,credit_card_data[,1:10])
pred2
sum(pred2 == credit_card_data[,11])/ nrow(credit_card_data)
#rbfdot gives a better prediction with a 10% higher accuracy at 0.957

#exploring another kernel for ksvm "splinedot"
model3 <- ksvm(credit_card_data[,1:10],credit_card_data[,11],type="C-svc",kernel="splinedot",C=100,scaled=TRUE)
a <- colSums(model3@xmatrix[[1]] * model3@coef[[1]])
a
a0 <- -model3@b
a0
pred3 <- predict(model3,credit_card_data[,1:10])
pred3
sum(pred3 == credit_card_data[,11])/ nrow(credit_card_data)
#spline dot also provides a better prediction showing that this data is better
#described by a more advanced model rather than a simple linear model such
# vanilla dot



#question 3: kknn model
library(kknn)

data = read.table("credit_card_data.txt")
Sample <- sample(1:150, 50)
data.test <- data[Sample, ]
data.train <- data[-Sample, ]
dim(data)

dim(data.test)
dim(data.train)

# we set kmax = 9 as it minimizes the mean squared error shown by the plot:
model4 <- train.kknn(V11 ~ ., data = data.train, kmax = 9)
model4

for (t in seq(0.4, 0.85, 0.05)){
  
  prediction <- predict(model4, data.test[, -11])
  prediction
  t_prediction = ifelse(prediction > t, 1 ,0)
  CM <- table(data.test[, 11], t_prediction)
  print(CM)
  accuracy <- (sum(diag(CM)))/sum(CM)
  print(accuracy)
  print(t)
  print(strrep('-', 10))
}


plot(model4)
