# CareLoop Clinics — No-Show Guard

## Project Overview
CareLoop Clinics — No-Show Guard is a healthcare analytics project designed to understand patient appointment no-shows, identify high-risk appointments, and analyze patient follow-up notes.

The project combines Python, SQL, Machine Learning, and Generative AI to generate actionable insights that can help clinics reduce missed appointments.

## Tools & Technologies
- Python
- Pandas and NumPy
- Scikit-learn
- MySQL
- Google Gemini API
- Google Colab
- SQL

## Project Structure

```text
CareLoop-Clinics-No-Show-Guard/
│
├── data/
│   ├── appointments.csv
│   ├── clinics.csv
│   └── followup_notes.csv
│
├── 01_ingest_clean.ipynb
├── rejected_rows.json
├── appointments_clean.csv
├── clinics_enriched.csv
├── load_data.sql
├── 02_queries.sql
├── 03_model.ipynb
├── test_risk_scores.csv
├── 04_genai.ipynb
├── notes_analysed.csv
└── README.md
```

## Part 1: Data Ingestion & Cleaning
- Processed 1,020 appointment records.
- Identified and separated 32 rejected records.
- Removed duplicate records and standardized categorical values.
- Handled missing values and outliers.
- Created features such as lead_days and no_show.
- Exported cleaned appointment and enriched clinic datasets.

Final cleaned dataset: 990 appointments.

## Part 2: SQL Analysis
Created MySQL tables and performed analytical queries to examine:
- Clinic-wise appointment volumes and no-show rates.
- No-show rates by booking lead-time buckets.
- Monthly appointment trends.
- Clinic rankings and comparisons against the overall no-show rate.

Overall no-show rate: 22.02%.

Key finding: Appointments booked 31 or more days in advance had a 60.5% no-show rate.

## Part 3: Machine Learning
Built a Logistic Regression classification model to predict appointment no-show risk.

Model evaluation:
- Accuracy: 65.2%
- Precision: 35.3%
- Recall: 68.2%
- F1 Score: 46.5%
- ROC-AUC: 0.715

Generated risk scores and classified test appointments into Low, Medium, and High risk categories.

Output: `test_risk_scores.csv`

## Part 4: Generative AI Analysis
Used the Google Gemini API to analyze 30 patient follow-up notes.

Extracted:
- Reason category
- Sentiment
- Urgency
- Recommended action

Output: `notes_analysed.csv`

## Key Outcomes
- Identified patterns associated with appointment no-shows.
- Compared clinic performance.
- Developed a machine learning model for no-show risk prediction.
- Used Generative AI to categorize patient feedback and suggest follow-up actions.

## Conclusion
The project demonstrates an end-to-end healthcare analytics workflow, from raw data cleaning and SQL analysis to predictive modeling and Generative AI-based text analysis.

The findings can help clinics identify potential no-shows and develop targeted patient reminder and follow-up strategies.

## Note
Weather data enrichment was attempted using Open-Meteo, but the API requests were unsuccessful. Missing temperature values were retained rather than fabricated.

This project was developed for learning and analytical purposes.
