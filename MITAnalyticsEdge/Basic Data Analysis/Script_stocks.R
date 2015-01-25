IBM = read.csv("IBMStock.csv")
str(IBM)
GE = read.csv("GEStock.csv")
PG = read.csv("ProcterGambleStock.csv")
Coke = read.csv("CocaColaStock.csv")
Boeing = read.csv("BoeingStock.csv")

# Assign 1

IBM$Date = as.Date(IBM$Date, "%m/%d/%y")

GE$Date = as.Date(GE$Date, "%m/%d/%y")

Coke$Date = as.Date(Coke$Date, "%m/%d/%y")

PG$Date = as.Date(PG$Date, "%m/%d/%y")

Boeing$Date = as.Date(Boeing$Date, "%m/%d/%y")
str(GE)
Which.min(IBM$Date)
GE$Date[which.min(GE$Date)]
PG$Date[which.min(PG$Date)]
GE$Date[which.max(GE$Date)]
PG$Date[which.max(PG$Date)]
mean(IBM$StockPrice, na.rm = TRUE)
min(GE$StockPrice, na.rm = TRUE)
GE$StockPrice[which.min(GE$StockPrice)]
Coke$StockPrice[which.max(Coke$StockPrice)]
Boeing$StockPrice[which.median(Boeing$StockPrice)]
median(Boeing$StockPrice, na.rm = TRUE)
sd(PG$StockPrice, na.rm = TRUE)
plot(Coke$Date,Coke$StockPrice,type="l",col ="red")
lines(PG$Date, PG$StockPrice, col ="blue")
abline(v=as.Date(c("2000-03-01")), lwd=2)
abline(v=as.Date(c("1983-03-01")), lwd=2)

plot(Coke$Date[301:432], Coke$StockPrice[301:432], type="l", col="red", ylim=c(0,210))
lines(Boeing$Date[301:432], Boeing$StockPrice[301:432],  col="green" )
lines(GE$Date[301:432], GE$StockPrice[301:432],  col="blue" )
lines(PG$Date[301:432], PG$StockPrice[301:432],  col="yellow" )
lines(IBM$Date[301:432], IBM$StockPrice[301:432],  col="purple" )
abline(v=as.Date(c("2000-03-01")), lwd=2)
abline(v=as.Date(c("1997-09-01")), lwd=1)
abline(v=as.Date(c("1997-11-30")), lwd=1)
abline(v=as.Date(c("2004-01-01")), lwd=1)
abline(v=as.Date(c("2005-12-31")), lwd=1)
tapply(IBM$StockPrice,IBM$Date, mean)

DateConvert = as.Date(strptime(IBM$Date, "%m/%d/%y %H:%M"))
IBM$Month = months(DateConvert)
tapply(IBM$StockPrice,IBM$Month, mean)
tapply(IBM$StockPrice,IBM$Month, mean)
