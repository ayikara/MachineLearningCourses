
CLM =read.csv("climate_change.csv")
str(CLM)
CLMTRG = subset(CLM, CLM$Year <2007)
CLMTEST = subset(CLM, CLM$Year >2006)
str(CLMTRG)
str(CLMTEST)

# Linear Regression (all variables for Lif expectancy)
modTemp1 = lm(CLMTRG$Temp ~ MEI + CO2 + CH4 + N2O + CFC.11 + CFC.12+ TSI+Aerosols, data=CLMTRG)
summary(modTemp1)

# Make test set predictions
TempTest = predict(modTemp1, newdata=CLMTEST)
TempTest

# Compute R-squared
SSE = sum((CLMTEST$Temp - TempTest)^2)
SST = sum((CLMTEST$Temp - mean(CLMTRG$Temp))^2)
1 - SSE/SST

cor(CLMTRG$N2O, CLMTRG$MEI)
cor(CLMTRG$N2O, CLMTRG$CO2)
cor(CLMTRG$N2O, CLMTRG$CH4)
cor(CLMTRG$N2O, CLMTRG$CFC.11)
cor(CLMTRG$N2O, CLMTRG$CFC.12)
cor(CLMTRG$N2O, CLMTRG$Aerosols)

cor(CLMTRG$CFC.11, CLMTRG$MEI)
cor(CLMTRG$CFC.11, CLMTRG$CO2)
cor(CLMTRG$CFC.11, CLMTRG$CH4)
cor(CLMTRG$CFC.11, CLMTRG$N2O)
cor(CLMTRG$CFC.11, CLMTRG$CFC.12)
cor(CLMTRG$CFC.11, CLMTRG$Aerosols)

modTemp2 = lm(CLMTRG$Temp ~ MEI + N2O + TSI+Aerosols, data=CLMTRG)
summary(modTemp2)

# Make test set predictions
TempTest = predict(modTemp2, newdata=CLMTEST)
TempTest

# Compute R-squared
SSE = sum((CLMTEST$Temp - TempTest)^2)
SST = sum((CLMTEST$Temp - mean(CLMTRG$Temp))^2)
1 - SSE/SST

modTStep = step(modTemp1)
summary(modTStep)