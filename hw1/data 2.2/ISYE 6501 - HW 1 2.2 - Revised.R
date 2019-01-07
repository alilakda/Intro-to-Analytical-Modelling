rm(list=ls())

setwd("/Users/MihirT/Desktop")
data = read.table("credit_card_data.txt")

library(kknn)

for (t in seq(0.40, 0.70, 0.05)){
  for (i in 1:nrow(data)){
    data.test = data[i,]
    data.train = data[-i,]
    
    model <- train.kknn(V11 ~ ., data = data.train, kmax = 9)
    model
    
    prediction <- predict(model, data.test[, -11])
    prediction
    
    t_prediction <- ifelse(prediction < t, 0, 1)
    
    if (t_prediction == data.test[, 11]){
      data$accuracy[i] = 100
    }
    else{
      data$accuracy[i] = 0
    }
    
  }
  
  total_accuracy = sum(data$accuracy)
  print(total_accuracy)
  
  final_accuracy = total_accuracy / (654*100)
  print(final_accuracy)
  print(t)
  print(strrep('--', 10))
}  
