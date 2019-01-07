#Question 4.2

rm(list = ls())
setwd("/Users/kunlelawal/Desktop/Masters/MSA/Classes/Fall2018/ISyE_6501/hw3")
crimedata = read.table("uscrime.txt", header = TRUE)
head(crimedata)
summary(crimedata$Crime)
hist(crimedata$Crime)
boxplot(crimedata$Crime)

table(crimedata$Crime)

install.packages("outliers")
require(outliers)
help("grubbs.test")
#Test is based by calculating score of this outlier G (outlier minus mean and divided by sd)
# Alternative method is calculating ratio of variances of two datasets - full dataset and dataset without outlier. 
#The obtained value called U
x = crimedata$Crime
grubbs.test(x) #want
grubbs.test(x, type = 11) #don't want
grubbs.test(x, type = 20)

hist(crimedata$Crime)

# 6.1
#Change in detection situation -> AWS EC2 server usage (might be having a sale)
#Using CUSUM, what is critical val and threshold ->

"
Example: Heart beats per minute when working out in the gym
max_heart_rate: (220bpm - age)
normal = less than 0.85(max_heart_rate)
Critical value -> 
The rate of change of your heart beats within time range. 
for example when you'r working out, you don't want your heart rate to change to fast
because it could be a sign of cardiac arrest.
Threshold ->
max threshold: your heart rate is too high/overworking and you're burning muscle leading to muscle deterioration
min threshold: your heart rate is too low and you are not working out hard enough
"

#6.2
tempData = read.table("temps.txt", header = TRUE)
head(tempData)
install.packages("bda")
require(bda)
help(cusum) #seems k = c, h = threshold
x1 = tempData$X1996
x1
hist(x1)
m_x1 = mean(x1)
m_x1
test = cusum(x1, mu = m_x1)
test
plot(test)

install.packages("qcc")
require(qcc)
help(cusum)

data(robot)
head(robot)
data = robot[!is.na(robot$TMHSTMIN), ]
hst = data$TMHSTMIN
hst
mean(hst)
out = cusum(hst,mu=45)
plot(out)
