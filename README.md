# An Empirical Investigation of the Impact of Monetary Policy on Montana's Economy

This project is part of ECON 112 coursework at UC San Diego and explores the causal effect of monetary policy on economic activities in Montana using Vector Autoregression (VAR) models.

## 🔍 Research Question
How does the federal funds interest rate impact:
- Real GDP growth
- Unemployment rate
...in the state of Montana?

## 🧪 Methodology
- Data Source: Federal Reserve Economic Data (FRED)
- Variables: Federal Funds Rate, Montana Real GDP, Montana Unemployment Rate
- Tools: R (`tseries`, `vars`), VAR model (Sims 1980), Impulse Response Functions
- Lag selection via AIC/BIC
- COVID period excluded in baseline, tested in robustness

## 📊 Key Findings
- **No significant effect** of interest rate on Montana’s output growth
- **Delayed but weak positive impact** on unemployment rate (visible after 5 quarters)

## 📁 Repository Structure
- `code/`: Contains R script used for analysis
- `report/`: Full PDF report of the project
- `plots/`: Selected visualizations from the paper
- `data/`: Placeholder only — data not included due to source policy

## 📝 Note
Data not included but reproducible using public datasets from [FRED](https://fred.stlouisfed.org/).

---
