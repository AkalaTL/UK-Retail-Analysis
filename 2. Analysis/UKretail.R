#Build a predictive model explaining either:
#- time until next order per customer, or 
#- revenue of next order per customer 

#data = mac.Documents.UKretail Test
library(data.table)
library(dplyr)
library(ggplot2)
library(scales)
ukretail <- fread("UKretail.csv")

#Frist explore the dataset, descriptive analysis
str(ukretail)
#fix datatype(Date,CustomerID)
#split date and time
ukretail[, InvoiceDate := as.POSIXct(InvoiceDate,tz="GMT")]
ukretail[, CustomerID := as.character(CustomerID)]
times <- format(as.POSIXct(ukretail$InvoiceDate,format="%Y-%m-%d %H:%M:%S"),"%H:%M:%S")
dates <- format(as.POSIXct(ukretail$InvoiceDate,format="%Y-%m-%d %H:%M:%S"),"%Y-%m-%d")

ukretail$times <- times
ukretail$dates <- dates
##Build time-series model
#Time series forecasting is the use of a model 
#to predict future values based on previously observed values.
#how many customers?
#how many purchase per day for each customer
#plot out time series of customer purchase record
#Revenue per customer = Number of units * unit price

#4325 customers
customers <- unique(ukretail$CustomerID)
sum(is.na(ukretail$CustomerID))
#Detect abnormally
summary(ukretail)
nd <- filter(uk)
ukretail[ukretail$UnitPrice<0 | ukretail$UnitPrice==38970.00 |ukretail$UnitPrice==17836.460,]
abnormal_quantity <- ukretail[(ukretail$Quantity<0 | ukretail$Quantity==12540.00),]
#remove outlier
nuk <- filter(ukretail,ukretail$UnitPrice>0 & ukretail$UnitPrice!=38970.00 & !is.na(ukretail$CustomerID))
nd <- filter(ukretail,ukretail$UnitPrice>0 & ukretail$UnitPrice!=38970.00)
#create dummy variables for catagorical Country
nd$Country = factor(nd$Country)
##Revenue per customer = Number of units * unit price
nd <- mutate(ukretail,Revenue = Quantity * UnitPrice)
ndsub <-nd[,c("InvoiceDate","CustomerID","Country","Revenue")]
trainsub <- training[,c("InvoiceDate","CustomerID","Country","Revenue")]
weather <- subset(weather, select = c(1,2,4,5))
# Predicting the Test set results using decision tree
#split data training and testing
library(caTools)
set.seed(123)
split = sample.split(nd$Revenue, SplitRatio = 0.8)
training = subset(nd, split == TRUE)
test = subset(nd, split == FALSE)
#lm
regressor = lm(formula = Revenue ~ .,
               data = trainsub)
y_pred = predict(regressor, newdata = test_set)
# decision tree
library(rpart)
regressor = rpart(formula = Revenue ~ .,
                  data = ndsub,
                  control = rpart.control(minsplit = 1))
# Predicting a new result with Decision Tree Regression
y_pred = predict(regressor, data.frame(Level = 6.5))

#Revenue per customer = Number of units * unit price
ukretail_rev <- mutate(ukretail,Revenue = Quantity * UnitPrice)
by_customer <- ukretail_rev %>% group_by(CustomerID) %>% summarise(Revenue = sum(Revenue))

#revenue by invoicedate
by_Date_rev <- ukretail_rev %>% group_by(InvoiceDate) %>% summarise(Revenue = sum(Revenue))
ggplot(by_Date_rev, aes(InvoiceDate,Revenue)) + geom_line()

#remove outliers
summary(ukretail_rev)
str(ukretail_rev)
count(ukretail_rev$Quantity)
#remove quantity,UnitPrice <0
ukretail_rev <- filter(ukretail_rev,Quantity < 0 & UnitPrice < 0)

outliers <-filter(by_Date_rev,Revenue < 0)











by_Date <- ukretail %>% group_by(InvoiceDate) %>% summarise(Numcustomers=n())
base = ggplot(by_Date, aes(InvoiceDate,Numcustomers)) + geom_line()
base+scale_x_datetime(date_breaks = "1 month")
2010-12-22 - 2011-01-10
by_Date_Gap1 <- by_Date[by_Date$InvoiceDate %in% 
                         seq(from = as.Date("2010-12-01"), length.out =30, by="day"),]
by_Date_Gap <- by_Date[by_Date$Date %in% 
                         seq(as.Date("2014-06-30"),as.Date("2015-01-01"),by="day"),]
