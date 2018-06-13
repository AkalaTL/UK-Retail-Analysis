#time series prediction of uk retail data
#Build a predictive model explaining either:
#- time until next order per customer, or 
#- revenue of next order per customer 
#data = mac.Documents.UKretail Test

library(forecast)

#split training and testing
library(caTools)
set.seed(123)
split = sample.split(ukretail$sales, SplitRatio = 0.8)
training = subset(ukretail, split == TRUE)
test = subset(ukretail, split == FALSE)
test_period <- max(test$InvoiceDate) - min(test$InvoiceDate) + 1
#pick a customer
c12352_test <- subset(test, CustomerID == 12352)
c12352_training <-subset(training, CustomerID ==12352)
Country <- 1 - c12352_training$Country
Country_t <- 1 - c12352_test$Country
  
y <- ts(c12352_training$sales, frequency=7)
z <- fourier(ts(c12352_training$sales, frequency=365.25), K=5)
zf <- fourierf(ts(c12352_training$sales, frequency=365.25), K=5, h=test_period)
fit <- auto.arima(y, xreg=cbind(z), seasonal=FALSE)
fc <- forecast(fit, xreg=cbind(zf), h=test_period)
plot(fc)

#log sales
y <- ts(c12352_training$logsales, frequency=7)
z <- fourier(ts(c12352_training$logsales, frequency=365.25), K=5)
zf <- fourierf(ts(c12352_training$logsales, frequency=365.25), K=5, h=test_period)
fit <- auto.arima(y, xreg=cbind(z), seasonal=FALSE)
fc <- forecast(fit, xreg=cbind(zf), h=test_period)
plot(fc)

ggplot(c12352_test, aes(InvoiceDate)) + 
  geom_line(aes(y = c12352_test$sales, colour = "Sales")) + 
  xlab("Test Period") + 
  ylab("Forecast of Customer 12352 Sales")



"y <- ts(training$sales, frequency=7)
z <- fourier(ts(training$sales, frequency=365.25), K=5)
zf <- fourierf(ts(training$sales, frequency=365.25), K=5, h=test_period)
fit <- auto.arima(y, xreg=cbind(z), seasonal=FALSE)
fc <- forecast(fit, xreg=cbind(zf), h=test_period)
plot(fc)"