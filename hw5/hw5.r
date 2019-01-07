setwd("/Users/alimujtaba/Google Drive/isye6501modelling/isye6501homeworks/hw5")
require(data.table)

crime_data <- read.table("uscrime.txt", header = TRUE)

crime_data


model <- lm(Crime ~ ., data = crime_data)

summary(model)


                                                  