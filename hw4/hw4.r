
rm(list=ls())
getwd()
setwd("/Users/alimujtaba/Google Drive/isye6501modelling/isye6501homeworks/hw4")
# temp_data <-read.table("temps.txt", header = TRUE)
#
# head(temp_data)
# summary(temp_data)
#
# df_data <- data.frame(temperature = c(temp_data[,"X1996"],temp_data[,"X1997"]))
#
# require(forecast)
# require(stats)
# temp_holt <- HoltWinters(temp_data, beta=FALSE, gamma=FALSE)
# temp_forecast <- forecast(temp_holt, 8)
# df_data
# matrix_data <- as.matrix(temp_data)
#
# matrix_data
#
# adjusted_data <- t(matrix_data)
#
# plot(adjusted_data)


data = read.table("~/Desktop/GT_MSA/isye6501/isye6501homeworks/hw4/temps.txt", header = TRUE)
datatimeseries = ts()
head(data)
datanew <- data.frame(temp = c(data[, 2], data[, 3], data[, 4], data[, 5], data[, 6], data[, 7],
                               data[, 8], data[, 9], data[, 10], data[, 11], data[, 12],
                               data[, 13], data[, 14], data[, 15], data[, 16],
                               data[, 17], data[, 18], data[, 19], data[, 20], data[, 21]))
head(datanew)
plot(datanew$temp, type='l')

plot(datanew$temp[1:500], type='l')

datanew2 <- datanew$temp[1:500]
temp_holt <- HoltWinters(datanew2, alpha = 0.01, beta=FALSE, gamma=FALSE)
temp_holt
plot(temp_holt)

myts <- ts(datanew2, start=c(1995), end=c(2015), frequency=1)
timeser = ts(datanew2, frequency = 20)
timeser
plot.ts(timeser)
timedecomp <- decompose(timeser)
holt <- HoltWinters(fullts)
holt
plot.ts(fullts)
plot(holt, lwd = 3)
plot(timedecomp)
alpha_values = list(0.01, 0.025, 0.030, 0.045, 0.05, 0.060, 0.065, 0.070)
for (i in alpha_values) {
smooth <- HoltWinters(datanew2, alpha = i, beta = FALSE ,gamma = FALSE)
smooth
#plot.ts(datanew2 ,main = i)
plot(smooth, main = i)
}
timeser = ts(datanew, frequency = 2)
smooth <- HoltWinters(timeser, alpha = 0.04, beta = FALSE, gamma = FALSE)
smooth
#plot.ts(datanew2 ,main = i)
plot(smooth, main = 0.06, lwd = 3)



fullts <- ts(datanew$temp, start=c(1995), end=c(2015), frequency=123)
fullts
plot.ts(fullts)
holt <- HoltWinters(fullts)
fitted(holt)[,2]
plot(holt, lwd = 3)

for (i in 0:8){
  ts_chunk <- ts(fullts[((i*246):((i+1)*246))], start=c(1995 + i*2), 
                 end=c(1995 + (i+1)*2), frequency=246)
  holt_chunk <- ts(fitted(holt)[,2][((i*246):((i+1)*246))], start=c(1995 + i*2), 
                    end=c(1995 + (i+1)*2), frequency=246)
  plot.ts(ts_chunk)
  lines(holt_chunk, lwd = 3, col = 'red')
}
ts_chunk <- ts(fullts[((0*492):((0+1)*492))], start=c(1995 + 0*4), 
               end=c(1995 + (0+1)*4), frequency=492)
holt <- HoltWinters(ts_chunk)
plot.ts(ts_chunk)
plot(holt, lwd = 3)
