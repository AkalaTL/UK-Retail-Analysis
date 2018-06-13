##Exploration and vistualization of ukretail datasets
##data:mac-Documents-UKretail test

#Load data
ukretail <- read.csv("UKretail.csv")

#split date and time
ukretail[, InvoiceDate := as.POSIXct(InvoiceDate,tz="GMT")]
ukretail[, CustomerID := as.character(CustomerID)]
ukretail$dates <- format(as.POSIXct(ukretail$InvoiceDate,format="%Y-%m-%d %H:%M:%S"),"%Y-%m-%d")
ukretail$month <- as.factor(format(as.POSIXct(ukretail$InvoiceDate,format="%Y-%m-%d %H:%M:%S"),"%m"))
ukretail$day <- as.factor(format(as.POSIXct(ukretail$InvoiceDate,format="%Y-%m-%d %H:%M:%S"),"%d"))
ukretail$weekday <- as.factor(format(as.POSIXct(ukretail$InvoiceDate,format="%Y-%m-%d %H:%M:%S"),"%u"))
ukretail$hour <- as.factor(format(as.POSIXct(ukretail$InvoiceDate,format="%Y-%m-%d %H:%M:%S"),"%H"))
ukretail$sales <-ukretail$Quantity * ukretail$UnitPrice
##by date/time
#look at the hist of date and time
d <- ggplot(ukretail,aes(hour))+
  scale_x_discrete()
d + geom_bar()
#date/time with highest sales
d + stat_summary_bin(aes(y = sales), fun.y = "sum", geom = "bar")

#new list group by customerID
customer <- arrange(ukretail,CustomerID)
groupCustomer <- group_by(customer,CustomerID)
CustomerSummaryTable <- group_by(customer,CustomerID) %>%
  summarise(sumofsales = sum(sales),
            meanofsales = mean(sales),
            numberofpurchase = n_distinct(InvoiceDate),
            menaGapday = ((max(InvoiceDate)-min(InvoiceDate))/numberofpurchase))

#quickcheck
c12352 <-filter(customer,CustomerID == "12352")
