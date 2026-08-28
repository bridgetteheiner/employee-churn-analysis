# Enterprise Workforce Churn & Capacity Forecasting Model
### A 3-Part Analytical Framework (Who, When, Where) for Global Headcount Retention

[![R](https://img.shields.io/badge/R-4.2+-blue.svg)](https://www.r-project.org/)
[![Python](https://img.shields.io/badge/Python-3.9+-green.svg)](https://www.python.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## Executive Summary

Enterprise employee turnover creates massive operational disruption and replacement overhead. This project was developed as a client capstone for a Fortune 500 enterprise managing **95,000+ employees across 27+ countries**. 

Instead of treating employee attrition as a monolithic classification task, this solution decomposes the problem into an actionable, 3-tier analytical framework:
1. **WHO** is at risk of leaving? *(Supervised Classification)*
2. **WHEN** are departures concentrated? *(Time-Series & Bayesian Forecasting)*
3. **WHERE** are geographic and organizational hotspots? *(Spatial & Regional Capacity Analysis)*

---

## Business Impact & Results

* **93.4% Recall & 81.8% AUC:** Optimized classification models to catch flight-risk employees early, deliberately favoring recall over precision to minimize unflagged turnover costs.
* **Long-Range Capacity Planning (RMSE 66.07):** Forecasted regional 24-month headcount attrition using Bayesian generalized additive models (**Facebook Prophet**), allowing HR leadership to proactively budget replacement hiring queues.
* **Actionable Driver Isolation:** Pinpointed compa-ratio disparities, promotion velocity gaps, and tenure thresholds as primary drivers of preventable voluntary departures.

---

## System Architecture & Workflow
