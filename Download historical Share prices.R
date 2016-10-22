####Using quantmod####
####Single Stock data####
if(!require(quantmod)){install.packages("quantmod")}
getSymbols("WIPRO.Ns", from="2015-01-01", to="2016-10-20")

#### multiple Stocks data Method-1 (each as seperate dataset) ####
getSymbols("WIPRO.NS;TCS.NS;INFY.NS", from="2015-01-01", to="2016-10-20")

#### multiple Stocks Method-2 (using list)####
stocklist <- c("WIPRO.NS","TCS.NS","INFY.NS","AAPL")
getSymbols(stocklist, from="2015-01-01", to="2016-10-20")

####multiple Stocks Method-3####
stocklist <- c("WIPRO.NS","TCS.NS","INFY.NS","AAPL") # create list of stock tickers
Adjclose <- NULL
for (Ticker in stocklist)
  Adjclose <- cbind(Adjclose,getSymbols.yahoo(Ticker, from="2015-01-01", verbose=FALSE, auto.assign=FALSE)[,6]) #get data for companies in list, [,6] = keep the adjusted prices
FinalAdjclose <- na.locf(Adjclose) #copy last traded price in empty cell
FinalAdjclose1 <- Adjclose[apply(Adjclose,1,function(x) all(!is.na(x))),] #keep only dates having closing price
####Export the data to excel####
if(!require(timeSeries)){install.packages("timeSeries")}
data <- as.timeSeries(FinalAdjclose1)
write.csv(data, "data.csv")
