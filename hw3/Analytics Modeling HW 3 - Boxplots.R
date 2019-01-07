rm(list = ls())
setwd("/Users/MihirT/Desktop")
dat <- read.csv("cusum_excel.csv", header = TRUE)

head(dat)

library(ggplot2)

summary(dat$st.1996)
boxplot(dat$st.1996)

summary(dat$st.1997)
boxplot(dat$st.1997)

summary(dat$st.1998)
boxplot(dat$st.1998)

summary(dat$st.1999)
boxplot(dat$st.1999)

summary(dat$st.2000)
boxplot(dat$st.2000)

summary(dat$st.2001)
boxplot(dat$st.2001)

summary(dat$st.2002)
boxplot(dat$st.2002)

summary(dat$st.2003)
boxplot(dat$st.2003)

summary(dat$st.2004)
boxplot(dat$st.2004)

summary(dat$st.2005)
boxplot(dat$st.2005)

summary(dat$st.2006)
boxplot(dat$st.2006)

summary(dat$st.2007)
boxplot(dat$st.2007)

summary(dat$st.2008)
boxplot(dat$st.2008)

summary(dat$st.2009)
boxplot(dat$st.2009)

summary(dat$st.2010)
boxplot(dat$st.2010)

summary(dat$st.2011)
boxplot(dat$st.2011)

summary(dat$st.2012)
boxplot(dat$st.2012)

summary(dat$st.2013)
boxplot(dat$st.2013)

summary(dat$st.2014)
boxplot(dat$st.2014)

summary(dat$st.2015)
boxplot(dat$st.2015)
