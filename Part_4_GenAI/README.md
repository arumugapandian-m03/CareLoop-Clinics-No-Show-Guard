# CareLoop Clinics — No-Show Guard

**GitHub Repository:** https://github.com/arumugapandian-m03/CareLoop-Clinics-No-Show-Guard

## Project Overview

CareLoop Clinics — No-Show Guard is a data analytics and machine learning project
that studies patient appointment no-shows across eight clinics. It combines data
cleaning, SQL analytics, predictive modelling and Generative AI analysis of
patient follow-up notes to suggest practical ways to reduce missed appointments.

## Key Findings

1. **Part 1 — Data Foundations:** Cleaned 990 appointments from an initial
   dataset of 1,020 records. The observed no-show rate was 22.02%.

2. **Part 2 — SQL Analytics:** Clinic C08 had the highest no-show rate at
   33.33%. Appointments booked 31–45 days ahead had a 60.47% no-show rate
   (based on 43 appointments).

3. **Part 3 — Machine Learning:** The tuned Random Forest achieved a test
   ROC-AUC of 0.7075 and a test F1 score of 0.4643. Its best cross-validation
   F1 score was 0.5047.

4. **Part 4 — Generative AI:** Gemini analysed 9 nonblank follow-up notes
   successfully, while 1 blank note was skipped. Both notes classified as
   forgot_or_no_reminder belonged to appointments where no reminder was sent.

## Business Recommendation

CareLoop Clinics should introduce a targeted appointment-retention programme.
The overall no-show rate is 22.02% across 990 cleaned appointments, while clinic
C08 has a particularly high rate of 33.33%, making it a priority for operational
review. Long booking lead times also deserve attention: the 31–45-day group had
a 60.47% no-show rate across 43 appointments. The tuned Random Forest provides
a useful risk-ranking starting point, with a test ROC-AUC of 0.7075, although
its test F1 score of 0.4643 shows that predictions still need improvement.
In the 10-note GenAI illustration, both patients classified as
forgot_or_no_reminder had received no reminder, and 5 of the 10 appointments
had no reminder recorded. Clinics should therefore audit reminder delivery,
confirm patient contact details, prioritise follow-up for higher-risk
appointments, and investigate transport, cost, illness and scheduling barriers.
These actions should be tested through a monitored pilot before wider rollout.

## Selected Machine Learning Model

**Selected model:** Tuned Random Forest Classifier.

The tuned Random Forest was selected because it achieved the best
cross-validation F1 score of 0.5047 among the evaluated models after
hyperparameter tuning. On the held-out test set, it achieved:

- Accuracy: 0.6970
- Precision: 0.3824
- Recall: 0.5909
- F1 score: 0.4643
- ROC-AUC: 0.7075

The classification threshold was 0.50, the default probability threshold.
The model is intended as a decision-support tool, not as a definitive
prediction of an individual patient's behaviour.

## Limitations

1. **Limited GenAI sample:** Only 10 follow-up notes were analysed. This is
   an illustration and cannot establish the true distribution of reasons
   for missed appointments across all clinics.

2. **Patient overlap:** The random train/test split may place appointments
   belonging to the same patient in both sets. This can make evaluation
   results more optimistic than performance on entirely unseen patients.

3. **Random rather than temporal split:** The model was evaluated using a
   random split rather than training on earlier dates and testing on later
   dates. Real-world future performance may therefore differ.

## Technology Stack

- Python
- Pandas and NumPy
- Matplotlib and Seaborn
- Scikit-learn
- MySQL
- Google Gemini API
- Pydantic
- Jupyter Notebook

## Project Structure

- `Part_1_Data_Foundations/` — ingestion, cleaning and weather enrichment
- `Part_2_SQL_Analytics/` — SQL database and analytical queries
- `Part_3_Machine_Learning/` — model training, evaluation and saved outputs
- `Part_4_GenAI/` — Gemini note analysis, validation and recommendations

## Responsible Use

The model and GenAI outputs should support clinic staff rather than replace
human judgement. Patient follow-up recommendations should be reviewed by
authorised staff, and API keys or other secrets must never be committed
to the repository.
