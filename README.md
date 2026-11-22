# CareLoop Clinics — No-Show Guard

**A Data Science, Machine Learning and Generative AI Capstone Project**

## Overview

CareLoop Clinics — No-Show Guard analyses patient appointment no-shows across eight clinics. The project combines Python data engineering, SQL analytics, machine learning prediction and Gemini-powered analysis of patient follow-up notes.

## Project Results

| Part | Work completed | Key result |
|---|---|---|
| Part 1 — Data Foundations | Data cleaning and weather enrichment | 990 cleaned appointments; 22.02% no-show rate |
| Part 2 — SQL Analytics | Clinic and appointment analysis | C08 highest no-show rate: 33.33% |
| Part 3 — Machine Learning | Three models, cross-validation and tuning | Tuned Random Forest test ROC-AUC: 0.7075 |
| Part 4 — Generative AI | Gemini note classification and Pydantic validation | 9 nonblank notes analysed; 1 blank note skipped |

## Business Objective

Identify appointment no-show patterns, predict patients at risk of missing appointments, understand reasons from follow-up notes, and recommend practical clinic interventions.

## Repository Structure

```text
CareLoop_Clinics_Capstone/
│
├── Part_1_Data_Foundations/
│   ├── appointments_clean.csv
│   ├── clinics_enriched.csv
│   ├── clinic_daily_weather.csv
│   ├── rejected_rows.json
│   ├── unknown_outcomes.csv
│   └── Part_1_Data_Foundations.sql
│
├── Part_2_SQL_Analytics/
│   └── Part_2_SQL_Analytics.sql
│
├── Part_3_Machine_Learning/
│   ├── 03_model.ipynb
│   └── outputs/
│       ├── best_no_show_model.pkl
│       ├── model_comparison.csv
│       └── test_risk_scores.csv
│
└── Part_4_GenAI/
    ├── 04_genai.ipynb
    ├── followup_notes.csv
    ├── notes_analysed.csv
    └── README.md
```

## Selected Model

The tuned Random Forest was selected based on the best cross-validation F1 score of 0.5047. Its held-out test results were:

- Accuracy: 0.6970
- Precision: 0.3824
- Recall: 0.5909
- F1 score: 0.4643
- ROC-AUC: 0.7075
- Classification threshold: 0.50

## Technology Stack

Python, Pandas, NumPy, Scikit-learn, MySQL, Google Gemini API, Pydantic and Jupyter Notebook.

## Limitations

- Only 10 follow-up notes were analysed by GenAI; this is not representative of all clinic no-show reasons.
- The random train/test split may place appointments from the same patient in both sets.
- A random split does not fully simulate predicting future appointments from past data.

## Responsible Use

Predictions are intended to support clinic staff, not replace human judgement. GenAI classifications should be reviewed before operational decisions. API keys and credentials must never be committed to this repository.

## Detailed GenAI Report

See [Part 4 README](Part_4_GenAI/README.md) for the detailed business recommendation and GenAI results.
