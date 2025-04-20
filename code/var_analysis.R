
# ----------------------------------------------------------
# VAR Analysis of Monetary Policy Impact on Montana's Economy
# Author: Mingtian Chen
# Description: Estimate the causal effect of federal funds rate on
# Montana's output growth and unemployment using VAR models.
# ----------------------------------------------------------

# --- Load libraries ---
library(tseries)
library(vars)

# --- 1. Montana Real GDP & Interest Rate Analysis (Pre-COVID) ---

# Load Montana real GDP (quarterly)
data.gdp <- read.csv("Montana_RealGDP.csv")
rgdp <- ts(data.gdp[, 2], start = 1997, frequency = 4)

# Load Fed funds rate (monthly), aggregate to quarterly
data.ff <- read.csv("FEDFUNDS.csv")
ffrate <- ts(data.ff[, 2], frequency = 12, start = c(1954, 7))
int <- aggregate(ffrate, nfrequency = 4, mean)

# Compute GDP growth rate as first log difference
dlrgdp <- 400 * diff(log(rgdp))

# Trim to same period, exclude COVID era
y <- window(dlrgdp, start = c(1997, 2), end = c(2020, 1))
int <- window(int, start = c(1997, 2), end = c(2020, 1))

# Bind variables for VAR
data.y.int <- ts(cbind(y, int))

# Check autocorrelation structure
acf(data.y.int)
ccf(y, int)
pacf(data.y.int)

# Determine optimal lag using information criteria
VARselect(data.y.int, lag.max = 16, type = "const")

# Estimate VAR with 2 lags and summarize
var.y.int <- VAR(data.y.int, p = 2)
summary(var.y.int)

# Plot diagnostic plots and IRF
plot(var.y.int)
irf.y.int <- irf(var.y.int, ortho = TRUE, ci = 0.95, runs = 100, n.ahead = 16)
plot(irf.y.int)

# Robustness: use 4 lags
var.y.int2 <- VAR(data.y.int, p = 4)
summary(var.y.int2)
irf.y.int2 <- irf(var.y.int2, ortho = TRUE, ci = 0.95, runs = 100, n.ahead = 16)
plot(irf.y.int2)


# --- 2. Montana Unemployment Rate & Interest Rate Analysis (Pre-COVID) ---

# Load Montana unemployment rate (monthly), aggregate to quarterly
data.ur <- read.csv("MTUR.csv")
ur <- ts(data.ur[, 2], frequency = 12, start = c(1976, 1))
urate <- aggregate(ur, nfrequency = 4, mean)

# Trim both series
urate <- window(urate, start = c(1976, 1), end = c(2020, 1))
irate <- window(aggregate(ffrate, nfrequency = 4, mean), start = c(1976, 1), end = c(2020, 1))

# Combine data and run standard VAR flow
data.urate.irate <- ts(cbind(urate, irate))
acf(data.urate.irate)
ccf(urate, irate)
pacf(data.urate.irate)

VARselect(data.urate.irate, lag.max = 16, type = "const")
var.urate.irate <- VAR(data.urate.irate, p = 4)
summary(var.urate.irate)

plot(var.urate.irate)
irf.urate.irate <- irf(var.urate.irate, ortho = TRUE, ci = 0.95, runs = 100, n.ahead = 16)
plot(irf.urate.irate)

# Robustness with 6 lags
var.urate.irate2 <- VAR(data.urate.irate, p = 6)
summary(var.urate.irate2)
irf.urate.irate2 <- irf(var.urate.irate2, ortho = TRUE, ci = 0.95, runs = 100, n.ahead = 16)
plot(irf.urate.irate2)


# --- 3. Reanalysis Including COVID Period (2020–2022) ---

# GDP & Interest Rate with COVID
rgdp_withc <- ts(data.gdp[, 2], start = 1997, frequency = 4)
dlrgdp_withc <- 400 * diff(log(rgdp_withc))
int_withc <- aggregate(ffrate, nfrequency = 4, mean)

y_withc <- window(dlrgdp_withc, start = c(1997, 2), end = c(2022, 4))
int_withc <- window(int_withc, start = c(1997, 2), end = c(2022, 4))
data.y_withc.int_withc <- ts(cbind(y_withc, int_withc))

acf(data.y_withc.int_withc)
ccf(y_withc, int_withc)
pacf(data.y_withc.int_withc)
VARselect(data.y_withc.int_withc, lag.max = 16, type = "const")

var.y_withc.int_withc <- VAR(data.y_withc.int_withc, p = 2)
summary(var.y_withc.int_withc)
plot(var.y_withc.int_withc)

irf.y_withc.int_withc <- irf(var.y_withc.int_withc, ortho = TRUE, ci = 0.95, runs = 100, n.ahead = 16)
plot(irf.y_withc.int_withc)

# Robustness
var.y_withc.int_withc2 <- VAR(data.y_withc.int_withc, p = 4)
summary(var.y_withc.int_withc2)
irf.y_withc.int_withc2 <- irf(var.y_withc.int_withc2, ortho = TRUE, ci = 0.95, runs = 100, n.ahead = 16)
plot(irf.y_withc.int_withc2)


# --- 4. Unemployment & Interest Rate with COVID Period ---

ur_withc <- ts(data.ur[, 2], frequency = 12, start = c(1976, 1))
urate_withc <- aggregate(ur_withc, nfrequency = 4, mean)
urate_withc <- window(urate_withc, start = c(1976, 1), end = c(2023, 1))
irate_withc <- window(aggregate(ffrate, nfrequency = 4, mean), start = c(1976, 1), end = c(2023, 1))

data.urate_withc.irate_withc <- ts(cbind(urate_withc, irate_withc))
acf(data.urate_withc.irate_withc)
ccf(urate_withc, irate_withc)
pacf(data.urate_withc.irate_withc)
VARselect(data.urate_withc.irate_withc, lag.max = 16, type = "const")

var.urate_withc.irate_withc <- VAR(data.urate_withc.irate_withc, p = 3)
summary(var.urate_withc.irate_withc)
plot(var.urate_withc.irate_withc)

irf.urate_withc.irate_withc <- irf(var.urate_withc.irate_withc, ortho = TRUE, ci = 0.95, runs = 100, n.ahead = 16)
plot(irf.urate_withc.irate_withc)

# Robustness: lag = 1 and 6
var.urate_withc.irate_withc2 <- VAR(data.urate_withc.irate_withc, p = 1)
summary(var.urate_withc.irate_withc2)
irf.urate_withc.irate_withc2 <- irf(var.urate_withc.irate_withc2, ortho = TRUE, ci = 0.95, runs = 100, n.ahead = 16)
plot(irf.urate_withc.irate_withc2)

var.urate_withc.irate_withc3 <- VAR(data.urate_withc.irate_withc, p = 6)
summary(var.urate_withc.irate_withc3)
irf.urate_withc.irate_withc3 <- irf(var.urate_withc.irate_withc3, ortho = TRUE, ci = 0.95, runs = 100, n.ahead = 16)
plot(irf.urate_withc.irate_withc3)
