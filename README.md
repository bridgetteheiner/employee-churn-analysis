# Enterprise Workforce Attrition & Headcount Forecasting

A predictive analytics, workforce segmentation, and time-series forecasting pipeline built in R to analyze employee turnover drivers, profile workforce cohorts, and project monthly organizational exits.

---

## 📌 Executive Summary

Employee turnover poses significant financial and operational burdens on enterprises. This project addresses workforce planning through a multi-model approach:
1. **Classification Modeling:** Identifies key employee attributes correlated with voluntary departures to support proactive retention strategies.
2. **Workforce Segmentation (Clustering):** Groups employees into distinct risk and compensation profiles using unsupervised hierarchical and K-Means clustering.
3. **Time-Series Forecasting:** Projects monthly termination volume over a 24-month horizon to enable data-driven talent acquisition and proactive backfill planning.

---

## 🛠️ Tech Stack & Methods

* **Language & Core Libraries:** R (`tidyverse`, `tidymodels`, `caret`, `recipes`, `dplyr`)
* **Supervised Models:** Decision Trees (`tree`, `rpart`, `C50`)
* **Unsupervised Clustering:** Hierarchical Ward's Method (`hclust`), K-Means (`kmeans`)
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
* **Model Performance:** Evaluated tree-based classifiers against test data, with the **C5.0 decision tree model achieving the top baseline accuracy of 76.5%** and isolating compensation ratio and tenure as primary predictors.

### 3. Unsupervised Workforce Segmentation
* Standardized numeric features (compensation, tenure, replacement multiplier) to mean 0, variance 1.
* Applied **Hierarchical Clustering (Ward's Method)** and evaluated dendrogram cuts across Euclidean distance thresholds.
* Segmented employee base into 4 distinct operational clusters using **K-Means Clustering** to profile turnover risk cohorts against compensation tiers.

### 4. Headcount Demand Forecasting
* Aggregated historical monthly termination records into a regular time series (`ts`, frequency = 12).
* Fitted an optimal seasonal/non-seasonal `auto.arima()` model to capture underlying trend and seasonality.
* Generated a 24-month forward-looking headcount exit forecast with 95% confidence intervals.

---

## 🚀 How to Run

1. Clone the repository:
git clone https://github.com/bridgetteheiner/employee-churn-analysis.git
cd employee-churn-analysis

2. Install dependencies in R:
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, tidymodels, caret, recipes, tree, rpart, rpart.plot, C50, ROCR, pROC, PRROC, forecast, readxl, dplyr)

3. Execute the classification and forecasting pipeline:
source("employee_attrition_models.R")

4. Execute the clustering analysis:
source("employee_segmentation_clustering.R")
