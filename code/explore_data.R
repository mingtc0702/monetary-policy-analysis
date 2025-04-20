# explore_data.R
# Initial data inspection and descriptive statistics

# Load data
data.gdp <- read.csv("Montana_RealGDP.csv")
data.ur <- read.csv("MTUR.csv")
data.ff <- read.csv("FEDFUNDS.csv")

# Quick summary
summary(data.gdp)
summary(data.ur)
summary(data.ff)

# Plot time series (GDP and interest)
ts.plot(ts(data.gdp[,2], start=1997, freq=4), main="Montana Real GDP")
ts.plot(ts(data.ff[,2], start=c(1954,7), freq=12), main="Fed Funds Rate")

# Check missing values
sum(is.na(data.gdp))
sum(is.na(data.ur))
sum(is.na(data.ff))
