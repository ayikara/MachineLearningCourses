data(state)

statedata = cbind(data.frame(state.x77), state.abb, state.area, state.center,  state.division, state.name, state.region)

str(statedata)
?state
plot(statedata$y,statedata$x)
plot(statedata$x,statedata$y)
x <- c(1:5); 
Y <- c(6:10);
plot(x,Y)

tapply(statedata$state.region,statedata$HS.Grad)
tapply(wArst$Arrest,chicagoC$Month,max,na.rm=TRUE)
tapply(statedata$HS.Grad,statedata$state.region,max,na.rm=TRUE)

boxplot(statedata$Murder ~ statedata$state.region)

neSub <- subset(statedata, statedata$state.region =="Northeast")
summary(neSub)
str(neSub)
boxplot(neSub$Murder ~ neSub$state.name)
plot(neSub$state.name,neSub$Murder)
neSub$Murder
neSub$state.name
table(neSub$Murder, neSub$state.name)

str(statedata)
# Linear Regression (all variables for Lif expectancy)
modLX1 = lm(Life.Exp ~ Population + Income + Illiteracy + Murder + HS.Grad + Frost+ Area, data=statedata)

modLX1

plot(statedata$Income, statedata$Life.Exp)
summary(modLX1)
modLX2 = lm(Life.Exp ~ Population + Income + Illiteracy + Murder + HS.Grad + Frost, data=statedata)
summary(modLX2)
modLX3 = lm(Life.Exp ~ Population + Income + Murder + HS.Grad + Frost, data=statedata)
summary(modLX3)
modLX4 = lm(Life.Exp ~ Population + Murder + HS.Grad + Frost, data=statedata)
summary(modLX4)

# Make predictions on test set
PredAge = predict(modLX4)
sort(PredAge)
which.min(statedata$Life.Exp) #This returns the Index
statedata$state.name[which.min(statedata$Life.Exp)] #returns the state name for index
statedata$Life.Exp[which.min(statedata$Life.Exp)]#This returns the value
min(statedata$Life.Exp)#This returns the value only

statedata$state.name[which.max(statedata$Life.Exp)] #returns the state name for index
statedata$Life.Exp[which.max(statedata$Life.Exp)]#This returns the value
resiM = resid(modLX4)


