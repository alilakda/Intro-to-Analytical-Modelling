require("kknn")
credit_card_data <- as.data.frame(credit_card_data)
train = credit_card_data[-1,]
test = credit_card_data[1,]
k <- kknn(credit_card_data$V11 ~ credit_card_data$V1 + credit_card_data$V2
                                + credit_card_data$V3 + credit_card_data$V4
                                + credit_card_data$V5 + credit_card_data$V6
                                + credit_card_data$V7 + credit_card_data$V8
                                + credit_card_data$V9 + credit_card_data$V10,
          train=train, test=test, k=3, distance=1)

summary(k)
fit <- fitted(k)
h <- table(credit_card_data$V11, fit)
print(h)

