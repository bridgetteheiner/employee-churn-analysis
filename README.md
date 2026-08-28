# 📊 Enterprise Workforce Churn & Capacity Forecasting Model
### A 3-Part Analytical Framework (Who, When, Where) for Global Headcount Retention 🚀

---

## 🌟 Portfolio & Website Summary Card

> **Global Workforce Churn & Capacity Forecasting Model** 💼  
> *Client Capstone: Fortune 500 Enterprise | Python, R, Prophet, Random Forest* 🛠️  
> 
> Decomposed an enterprise talent retention challenge across 95,000+ employees in 27+ countries into an actionable 3-part framework: **Who, When, and Where**. 
> * **👤 Who:** Engineered predictive classification models (Random Forest, C5.0) achieving **93.4% Recall and 81.8% AUC**, prioritizing recall to minimize unflagged flight-risk replacement costs.
> * **📅 When:** Modeled longitudinal departure trends using **Facebook Prophet** to forecast 24-month regional attrition thresholds (RMSE 66.07).
> * **📍 Where:** Delivered localized retention heatmaps and capacity planning metrics directly to organizational leadership.
> 
> [View GitHub Repository 🔗] [Read Full Case Study 📑]

---

## 📌 Executive Summary

Enterprise employee turnover creates massive operational disruption and replacement overhead. This project was developed as a client capstone for a Fortune 500 enterprise managing **95,000+ employees across 27+ countries**. 🌍

Instead of treating employee attrition as a monolithic classification task, this solution decomposes the problem into an actionable, 3-tier analytical framework:
1. **👤 WHO** is at risk of leaving? *(Supervised Classification)*
2. **📅 WHEN** are departures concentrated? *(Time-Series & Bayesian Forecasting)*
3. **📍 WHERE** are geographic and organizational hotspots? *(Spatial & Regional Capacity Analysis)*

---

## 📈 Business Impact & Key Results

* **🎯 93.4% Recall & 81.8% AUC:** Optimized classification models to catch flight-risk employees early, deliberately favoring recall over precision to minimize unflagged turnover costs.
* **🔮 Long-Range Capacity Planning (RMSE 66.07):** Forecasted regional 24-month headcount attrition using Bayesian generalized additive models (**Facebook Prophet**), allowing HR leadership to proactively budget replacement hiring queues.
* **💡 Actionable Driver Isolation:** Pinpointed compa-ratio disparities, promotion velocity gaps, and tenure thresholds as primary drivers of preventable voluntary departures.

---

## 🏗️ System Architecture & Workflow

    Raw Global HRIS Data (95k+ records, 27+ countries) 🌐
       |
       +---> ⚙️ Feature Engineering & Preprocessing
       |     |-- Compa-Ratio Binning & Salary Benchmarking 💵
       |     |-- One-Hot Encoding & Categorical Imputation 🧹
       |     \-- Class Imbalance Strategy (SMOTE / Stratified K-Fold) ⚖️
       |
       +---> 1. 👤 WHO: Risk Classification
       |     |-- Benchmark: Logistic Regression, rpart, C5.0, Random Forest 🌲
       |     \-- Optimal: Tuned Random Forest (AUC: 0.818 | Recall: 0.934) 🏆
       |
       +---> 2. 📅 WHEN: Longitudinal Time-Series
       |     |-- Benchmark: Moving Averages, Exponential Smoothing, ARIMA 📉
       |     \-- Optimal: Facebook Prophet (Weekly RMSE: 66.07) ⏳
       |
       \---> 3. 📍 WHERE: Regional Capacity Allocation
             \-- Country & Business-Unit Headcount Heatmaps & Cohort Drift 🗺️

---

## 1. 👤 WHO: Predictive Risk Classification

### 🔧 Feature Engineering
* **💵 Compa-Ratio Indexing:** Mapped base compensation against regional market medians to normalize pay equity across disparate countries.
* **⏳ Tenure Milestones:** Engineered non-linear tenure buckets to capture historical flight windows (e.g., 18–24 months).
* **📈 Promotion Velocity:** Modeled time elapsed since last role or grade advancement.

### 🧪 Model Benchmarking (5-Fold Cross-Validation)

| Model Architecture | Precision | Recall | F1-Score | ROC-AUC |
| :--- | :---: | :---: | :---: | :---: |
| Baseline Logistic Regression | 0.621 | 0.745 | 0.677 | 0.724 |
| Decision Tree (`rpart`) | 0.684 | 0.812 | 0.742 | 0.768 |
| C5.0 Rule-Based Classifier | 0.710 | 0.865 | 0.780 | 0.795 |
| **🏆 Tuned Random Forest** | **0.748** | **0.934** | **0.831** | **0.818** |

> **⚖️ Technical Trade-off Note:** In talent retention, the cost of a **False Negative** (an unflagged departure costing 50–150% of annual salary to backfill) is dramatically higher than a **False Positive** (a low-cost check-in by a manager). We explicitly shifted classification thresholds to maximize **Recall (0.934)** while maintaining an AUC of **0.818**.

---

## 2. 📅 WHEN: Temporal Headcount Forecasting

To prevent reactive hiring cycles, historical departure dates were aggregated to model future attrition volume over a 24-month horizon. 🗓️

* **🧠 Facebook Prophet Architecture:** Decomposed trends into overall baseline growth, annual hiring seasonality, and holiday-quarter departure lulls.
* **📊 Evaluation:** Outperformed traditional SARIMA and Holt-Winters Exponential Smoothing, yielding an overall weekly **RMSE of 66.07** across multi-country projections.

---

## 3. 📍 WHERE: Regional Hotspot Analysis

* 🗺️ Evaluated country-level turnover rates across all 27 operating regions.
* 🏢 Isolated specific departmental hubs experiencing anomalous attrition spikes, translating statistical flags into targeted retention budgets for local HR business partners.

---

## 📂 Repository Structure

    project_root/
    |-- data/
    |   \-- raw/                   # Schema definitions (Anonymized) 🔒
    |-- notebooks/
    |   |-- 01_eda_and_cleaning.ipynb 📓
    |   |-- 02_feature_engineering.ipynb 📓
    |   |-- 03_classification_models.ipynb 📓
    |   \-- 04_prophet_time_series.ipynb 📓
    |-- src/
    |   |-- preprocessing.py       # Imputation and encoding pipelines 🐍
    |   |-- modeling.py            # Training and evaluation routines 🐍
    |   \-- forecasting.R          # Prophet and time-series script 📊
    |-- reports/
    |   \-- executive_summary.pdf  # Stakeholder presentation deck 📑
    |-- README.md
    \-- requirements.txt

---

## 💻 Tech Stack & Libraries

* **Languages:** Python 3.9+ 🐍, R 4.2+ 📊
* **Machine Learning:** `scikit-learn`, `randomForest`, `rpart`, `C50`, `caret` 🤖
* **Time-Series:** `prophet`, `forecast`, `tseries` ⏳
* **Data Wrangling & Viz:** `pandas`, `numpy`, `dplyr`, `ggplot2`, `matplotlib`, `seaborn` 📈
