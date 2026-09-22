# PRD — Student Performance Prediction Using Regression

## 1. Project Overview

**Project Name:** Student Performance Prediction  
**Project Type:** Academic Machine Learning / Statistical Regression Project  
**Primary Tool:** RStudio  
**Programming Language:** R  
**Project Path (Windows):** `C:\Projects\student_performance_prediction`  
**Submission:** September 23, 2026

### Objective

Build a clean, minimal, statistically defensible regression model that predicts a student's **Exam Score** from academic, behavioral, and environmental factors.

The project must follow the regression model-building roadmap provided by the college:

1. Define the Problem
2. Identify Potential Predictors
3. Collect & Prepare Data
4. Exploratory Data Analysis
5. Build the Initial Model
6. Check Model Assumptions
7. Variable Selection / Model Refinement
8. Evaluate Model Performance
9. Validate the Model
10. Interpret & Finalize the Model
11. Prediction & Reporting

---

## 2. Problem Statement

Student examination performance can be affected by several academic, behavioral, and environmental factors. The goal is to determine whether these factors can be used to predict a student's final examination score using multiple linear regression.

### Research Question

> Can a student's exam score be predicted using measurable academic, behavioral, and environmental factors?

---

## 3. Dataset

### Planned Dataset

**Student Performance Factors**

Expected dataset characteristics:

- Approximately 6,607 student observations
- Approximately 20 variables
- Numerical and categorical predictors
- Target variable: `Exam_Score`

Potential predictors include:

- `Hours_Studied`
- `Attendance`
- `Previous_Scores`
- `Sleep_Hours`
- `Motivation_Level`
- `Parental_Involvement`
- `Access_to_Resources`
- `Tutoring_Sessions`
- `Family_Income`
- `Teacher_Quality`
- `School_Type`
- `Peer_Influence`
- `Physical_Activity`
- `Learning_Disabilities`
- `Parental_Education_Level`
- `Distance_from_Home`
- `Gender`
- Other available variables in the dataset

**Important:** Predictor selection will be based on actual data analysis and regression diagnostics. We will not blindly include every available variable in the final model.

---

## 4. Target Variable

### Dependent Variable

`Exam_Score`

This is a continuous numerical variable, therefore the project is a **regression problem**.

---

## 5. Primary Model

### Multiple Linear Regression

Initial model concept:

`Exam_Score ~ predictor_1 + predictor_2 + ... + predictor_n`

The initial model may contain a broad set of relevant predictors.

The final model will be refined using:

- Statistical significance
- Multicollinearity
- Regression assumptions
- Model performance
- Interpretability
- Validation performance

---

## 6. Project Philosophy

### Fast, Clean, Minimal

The project must avoid unnecessary complexity.

We will NOT add:

- Neural networks
- Large ML model collections
- Unnecessary dashboards
- Web applications
- Excessive feature engineering
- Random algorithms solely to improve a metric
- Hundreds of lines of unnecessary code

The goal is a model that is:

- Easy to understand
- Easy to explain in a viva
- Statistically justified
- Reproducible
- Efficient
- Appropriate for the college roadmap

### Accuracy and Error

We aim for strong predictive performance and low error through legitimate methods:

1. Proper data cleaning
2. Sensible predictor selection
3. Correct categorical-variable handling
4. Assumption checking
5. Multicollinearity checking
6. Model refinement
7. Train/test validation

We will never manipulate the data or evaluation process simply to obtain a better-looking metric.

---

## 7. Required Analysis Pipeline

### Stage 1 — Define the Problem

Document:

- Problem statement
- Objective
- Dependent variable
- Type of ML/statistical problem
- Expected practical use

### Stage 2 — Identify Potential Predictors

Investigate:

- Numerical variables
- Categorical variables
- Correlations
- Domain relevance
- Potential redundancy

Create an initial predictor set.

### Stage 3 — Collect & Prepare Data

Tasks:

- Import CSV
- Inspect dimensions
- Inspect data types
- Inspect summary statistics
- Check missing values
- Check duplicates
- Check obvious data-quality issues
- Convert categorical variables to appropriate factors
- Decide how missing values should be handled

All preprocessing decisions must be documented.

### Stage 4 — Exploratory Data Analysis

Required visualizations:

- Exam score distribution
- Study hours vs exam score
- Attendance vs exam score
- Previous scores vs exam score
- Correlation heatmap
- At least one categorical-variable comparison

Required statistics:

- Mean
- Median
- Standard deviation
- Minimum
- Maximum
- Relevant group summaries

### Stage 5 — Build Initial Model

Use multiple linear regression with relevant predictors.

Record:

- Coefficients
- Standard errors
- t-statistics
- p-values
- R²
- Adjusted R²
- F-statistic
- Residual standard error

### Stage 6 — Check Model Assumptions

Check:

#### Linearity
Residuals vs fitted values and relevant relationship plots.

#### Independence
Assess based on the structure of the observations and study design.

#### Homoscedasticity
Inspect residual spread.

#### Normality of residuals
Use:

- Q-Q plot
- Histogram if useful
- Statistical test with appropriate interpretation

#### Multicollinearity
Use VIF.

The project should explain what each assumption means and whether the model reasonably satisfies it.

### Stage 7 — Variable Selection / Model Refinement

Potential methods:

- Statistical significance
- VIF
- Backward/stepwise selection where appropriate
- Domain relevance
- Comparison of model fit

Compare the initial model with the refined model.

Do not remove variables solely because their p-value is above an arbitrary threshold without considering the overall model and interpretation.

### Stage 8 — Evaluate Model Performance

Report:

- R²
- Adjusted R²
- MAE
- MSE
- RMSE
- F-test
- Relevant coefficient tests

A comparison table should be created for initial and final models.

### Stage 9 — Validate the Model

Use a reproducible train/test split.

Planned approach:

- 80% training data
- 20% testing data
- Fixed random seed for reproducibility

Train the final model on the training set.

Evaluate predictions on unseen test data.

Required test metrics:

- MAE
- RMSE
- R²

Optional: cross-validation if it can be added without unnecessary complexity.

### Stage 10 — Interpret & Finalize

Explain:

- Important predictors
- Direction of relationships
- Meaning of selected coefficients
- Model fit
- Model limitations
- Why the final model was selected

Interpret coefficients in practical terms rather than only listing p-values.

### Stage 11 — Prediction & Reporting

Demonstrate prediction for a hypothetical/new student.

Example concept:

- Hours studied
- Attendance
- Previous score
- Sleep hours
- Motivation
- Tutoring
- Other final-model predictors

Output:

> Predicted Exam Score = X

The actual value must come from the trained model.

---

## 8. Expected Project Structure

```text
student_performance_prediction/
│
├── data/
│   └── StudentPerformanceFactors.csv
│
├── plots/
│   ├── exam_score_distribution.png
│   ├── study_hours_vs_score.png
│   ├── attendance_vs_score.png
│   ├── previous_scores_vs_score.png
│   ├── correlation_heatmap.png
│   ├── residual_plot.png
│   ├── qq_plot.png
│   └── actual_vs_predicted.png
│
├── output/
│   ├── model_summary.txt
│   ├── model_comparison.csv
│   └── predictions.csv
│
├── Student_Performance_Prediction.R
├── Student_Performance_Prediction.Rproj
├── README.md
└── PRD.md
```

The exact structure can be simplified if some outputs are not needed.

---

## 9. R Packages

Prefer a small package set.

Likely packages:

```r
library(tidyverse)
library(car)
```

Additional packages should only be added when they provide a clear benefit.

Base R should be preferred for standard regression calculations where practical.

---

## 10. Reproducibility

The project must use a fixed seed for train/test splitting.

Example:

```r
set.seed(123)
```

All important preprocessing and modelling decisions must be reproducible by running the main R script from a clean environment.

---

## 11. Model Evaluation Principles

The final model must be evaluated on data that was not used to fit the model.

Training performance alone must not be presented as evidence of predictive performance.

The final report must clearly distinguish:

- Training/model-fit metrics
- Testing/prediction metrics

---

## 12. Deliverables

### Required

1. RStudio project
2. R script
3. Dataset
4. Regression model
5. EDA plots
6. Assumption diagnostics
7. Model evaluation
8. Train/test validation
9. Example prediction
10. README
11. Project report/presentation material
12. Viva/Q&A preparation

### Optional

- Cross-validation
- Additional model comparison if justified
- Automated prediction function

---

## 13. GitHub References / Starting Points

Existing repositories will be used as references rather than copied blindly.

### Primary R reference

`cocobutterx13/Student-Performance-Analysis`

Useful components observed:

- StudentPerformanceFactors dataset
- Data cleaning
- Factor conversion
- Missing-value analysis
- EDA
- Correlation analysis
- Multiple linear regression
- R² / adjusted R²
- Residual analysis

The repository's train/test and some later analysis sections are incomplete, so our project will complete and improve those portions.

### Supporting prediction reference

`omaarrx/Student-Score-Prediction`

Useful for:

- Feature-combination experimentation
- Train/test prediction
- MSE
- R²
- Comparison of predictor sets

The notebook is Python-based, so its implementation will not be copied directly into the R project.

---

## 14. AI-Assisted Development

### Local Model

Primary coding assistant:

**Qwen3.5 4B — local Ollama model**

Use it for:

- R code generation
- Debugging
- Refactoring
- Explanation
- Documentation

The model is an assistant, not the source of statistical truth.

### Statistical Source of Truth

**RStudio/R**

All:

- coefficients
- p-values
- R²
- adjusted R²
- MAE
- MSE
- RMSE
- VIF
- residual diagnostics
- predictions

must be generated from the actual dataset and model.

AI-generated numerical results must never be assumed to be correct without running the R code.

---

## 15. Quality Requirements

The final project should be:

- Clean
- Minimal
- Reproducible
- Statistically defensible
- Easy to explain
- Visually clear
- Free of unnecessary dependencies
- Free of fabricated results
- Consistent with the college's regression roadmap

---

## 16. Viva Preparation

The project should allow straightforward answers to:

1. What is regression?
2. Why is this a regression problem?
3. What is the dependent variable?
4. What are independent variables?
5. Why did you select these predictors?
6. What is multiple linear regression?
7. What does R² mean?
8. What is adjusted R²?
9. What is MAE?
10. What is RMSE?
11. What is the difference between MAE and RMSE?
12. What is a p-value?
13. What is the null hypothesis?
14. What is the F-test?
15. What is multicollinearity?
16. What is VIF?
17. What are regression assumptions?
18. Why do we split training and testing data?
19. Why use a random seed?
20. How does the final model predict a new student's score?
21. What are the limitations of the model?

---

## 17. Current Status

**Status:** Project initialization

Completed:

- Topic selected
- College regression roadmap identified
- Dataset candidate selected
- GitHub references inspected
- Regression methodology selected
- Project scope defined

Next actions:

1. Obtain `StudentPerformanceFactors.csv`
2. Create RStudio project
3. Create folder structure
4. Import and inspect dataset
5. Perform Stage 1–4
6. Build initial regression model
7. Diagnose assumptions
8. Refine model
9. Validate
10. Generate final prediction
11. Prepare report and viva material

---

## 18. Important Rule for Future Work

Before adding a new model, package, visualization, or feature:

> Ask whether it directly supports one of the 11 stages in the college roadmap.

If not, leave it out unless there is a clear reason.

**Primary goal: finish a clean, correct, explainable regression project on time.**
