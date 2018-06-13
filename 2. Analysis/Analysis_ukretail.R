#Predict ukretail next purchase time or revenue following Data Science for Business Book
#data = mac.desktop.Data Science.Datasets.UKretail Test.Original Data
library(data.table)
library(dplyr)
library(ggplot2)
library(scales)
library(FSelector)

#Load data
ukretail <- fread("UKretail.csv")
#fix datatype
ukretail[, InvoiceDate := as.POSIXct(InvoiceDate,tz="GMT")]
ukretail[, CustomerID := as.character(CustomerID)]
ukretail[, Country := as.factor(Country)]
ukretail$dates <- format(as.POSIXct(ukretail$InvoiceDate,format="%Y-%m-%d %H:%M:%S"),"%Y-%m-%d")
ukretail$month <- as.factor(format(as.POSIXct(ukretail$InvoiceDate,format="%Y-%m-%d %H:%M:%S"),"%m"))
ukretail$day <- as.factor(format(as.POSIXct(ukretail$InvoiceDate,format="%Y-%m-%d %H:%M:%S"),"%d"))
ukretail$weekday <- as.factor(format(as.POSIXct(ukretail$InvoiceDate,format="%Y-%m-%d %H:%M:%S"),"%u"))
ukretail$hour <- as.factor(format(as.POSIXct(ukretail$InvoiceDate,format="%Y-%m-%d %H:%M:%S"),"%H"))
ukretail$sales <-ukretail$Quantity * ukretail$UnitPrice

#remove outlier
newuk <- ukretail%>%
  filter(UnitPrice >= 0)
write.csv(newuk, "newuk.csv")
write.csv(test_set, "test_set.csv")
write.csv(training_set,"train_set.csv")
##Information Gain for all features
weights <- information.gain(sales ~.,newuk)
print(weights)
subset <- cutoff.k(weights, 5)
f <- as.simple.formula(subset, "sales")
print(f)
 #try model
library(caTools)
set.seed(123)
split = sample.split(newuk$sales, SplitRatio = 0.75)
training_set = subset(newuk, split == TRUE)
test_set = subset(newuk, split == FALSE)

install.packages('randomForest')
library(randomForest)
set.seed(1234)
regressor1 = randomForest(sales ~ InvoiceNo + Description + StockCode + Quantity + CustomerID, data=training_set, importance = TRUE, proximity = TRUE,na.action=na.exclude)

# Predicting a new result with Random Forest Regression
y_pred = predict(regressor, data.frame(Level = 6.5))
