# Plots Summary

This folder contains selected visualizations generated from the VAR analysis, supporting the core findings of the project.

---

### 1. `irf_output_growth_pre_covid.png`
Impulse response of real GDP growth to a shock in the interest rate (pre-COVID). 
The response is short-lived and statistically insignificant beyond period 1.

---

### 2. `irf_unemployment_covid.png`
Impulse response of unemployment rate to interest rate shocks (including COVID period). 
Shows a delayed positive response peaking around period 6–10.

---

### 3. `acf_pacf_unemployment_covid.png`
Autocorrelation and cross-correlation plots of unemployment rate and interest rate (with COVID).
Supports the choice of lag structure for VAR modeling.

---

### 4. `macro_trend_urate_vs_rate.png` (optional)
Historical trends of unemployment rate and interest rate over time. 
Highlights long-term cyclical relationships.

---

All plots are generated using R with the `vars` package.
