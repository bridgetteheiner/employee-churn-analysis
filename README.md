# employee-churn-analysis

# Enterprise Workforce Attrition & Headcount Forecasting

A predictive analytics and time-series forecasting pipeline built in R to analyze employee attrition drivers and project monthly organizational turnover.

---

## 📌 Executive Summary

Employee turnover poses significant financial and operational burdens on enterprises. This project addresses workforce planning through a dual-modeling approach:
1. **Classification Modeling:** Identifies key employee attributes correlated with voluntary departures to support proactive retention strategies.
2. **Time-Series Forecasting:** Projects monthly termination volume over a 24-month horizon to enable data-driven talent acquisition and proactive backfill planning.

---

## 🛠️ Tech Stack & Methods

* **Language & Core Libraries:** R (`tidyverse`, `tidymodels`, `caret`, `recipes`)
* **Classification Models:** Decision Trees (`tree`, `rpart`, `C50`)
* **Time-Series Forecasting:** Auto-ARIMA (`forecast`)
* **Model Evaluation:** Confusion Matrices, Precision, Recall, F1-Score, ROC-AUC Curves (`pROC`, `ROCR`, `PRROC`)
* **Feature Engineering:** Dummy encoding, one-hot transformation, compa-ratio normalization, currency standardization, and missing value imputation.

---

## 📊 Analytical Workflow

### 1. Data Preprocessing & Feature Engineering
* Standardized base salary across global currencies to USD mid-point benchmarks.
* Extracted and transformed compensation indicators (`Compa_Ratio`, salary bands) and organizational attributes (`Work_Structure`, `Tenure_Bucket`, `Generation`, `Job_Category`).
* Cleaned categorical levels using recipes preprocessing (`step_other`) and dummy variable encoding.

### 2. Voluntary Attrition Classification
Trained and evaluated multiple tree-based classifiers on a 70/30 stratified train-test split:
* **`tree` & `rpart` Classification Trees:** Baseline interpretability and cost-complexity pruning (`plotcp`).
* **`C5.0` Decision Trees:** Evaluated boosted rules and extracted variable importance (`C5imp`) to surface key turnover indicators.
* **Evaluation Metrics:** Accuracy, Precision, Recall, F1-Score, and ROC curves across classification probability thresholds.

### 3. Headcount Demand Forecasting
* Aggregated historical monthly termination records into a regular time series (`ts`, frequency = 12).
* Fitted an optimal seasonal/non-seasonal `auto.arima()` model to capture underlying trend and seasonality.
* Generated a 24-month forward-looking headcount exit forecast with 95% confidence intervals.

---

## 🚀 How to Run

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/](https://github.com/)<your-username>/workforce-attrition-forecasting.git
   cd workforce-attrition-forecasting
