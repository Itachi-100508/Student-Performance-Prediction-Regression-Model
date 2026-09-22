# ============================================================
# STUDENT PERFORMANCE PREDICTION
# Multiple Linear Regression
# ============================================================

# Project: Student Performance Prediction
# Dataset: StudentPerformanceFactors.csv
# Target: Exam_Score
# Method: Multiple Linear Regression
#
# Roadmap:
# 1. Define Problem
# 2. Identify Predictors
# 3. Collect & Prepare Data
# 4. Exploratory Data Analysis
# 5. Build Initial Model
# 6. Check Model Assumptions
# 7. Model Refinement
# 8. Evaluate Model
# 9. Validate Model
# 10. Interpret & Finalize
# 11. Prediction & Reporting


# ============================================================
# 1. SETUP
# ============================================================

# Install once if required:
# install.packages("tidyverse")
# install.packages("car")

library(tidyverse)
library(car)


# ============================================================
# 2. DEFINE PROBLEM & IDENTIFY PREDICTORS
# ============================================================

# Objective:
# Predict a student's Exam_Score using academic, behavioral,
# and demographic factors.

# Target variable:
# Exam_Score

# Candidate predictors are all remaining variables in the dataset.


# ============================================================
# 3. LOAD & PREPARE DATA
# ============================================================

data <- read.csv("data/StudentPerformanceFactors.csv")

# Initial inspection
dim(data)
head(data)
str(data)
summary(data)

# Check missing values and duplicates
colSums(is.na(data))
sum(duplicated(data))

# Convert blank strings to NA
data[data == ""] <- NA

# Check missing values after blank-value conversion
colSums(is.na(data))

# Remove rows containing missing values
data <- na.omit(data)

# Convert categorical variables to factors
categorical_cols <- c(
  "Parental_Involvement",
  "Access_to_Resources",
  "Extracurricular_Activities",
  "Motivation_Level",
  "Internet_Access",
  "Family_Income",
  "Teacher_Quality",
  "School_Type",
  "Peer_Influence",
  "Learning_Disabilities",
  "Parental_Education_Level",
  "Distance_from_Home",
  "Gender"
)

data[categorical_cols] <- lapply(
  data[categorical_cols],
  factor
)

# Final dataset size
dim(data)
str(data)


# ============================================================
# 4. EXPLORATORY DATA ANALYSIS
# ============================================================

# 4.1 Exam Score Distribution
ggplot(data, aes(x = Exam_Score)) +
  geom_histogram(bins = 30) +
  labs(
    title = "Distribution of Exam Scores",
    x = "Exam Score",
    y = "Number of Students"
  )

# 4.2 Hours Studied vs Exam Score
ggplot(data, aes(x = Hours_Studied, y = Exam_Score)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Hours Studied vs Exam Score",
    x = "Hours Studied",
    y = "Exam Score"
  )

# 4.3 Attendance vs Exam Score
ggplot(data, aes(x = Attendance, y = Exam_Score)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Attendance vs Exam Score",
    x = "Attendance (%)",
    y = "Exam Score"
  )

# 4.4 Previous Scores vs Exam Score
ggplot(data, aes(x = Previous_Scores, y = Exam_Score)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Previous Scores vs Exam Score",
    x = "Previous Score",
    y = "Exam Score"
  )

# 4.5 Sleep Hours vs Exam Score
ggplot(data, aes(x = Sleep_Hours, y = Exam_Score)) +
  geom_boxplot() +
  labs(
    title = "Sleep Hours vs Exam Score",
    x = "Sleep Hours",
    y = "Exam Score"
  )


# ============================================================
# 5. CORRELATION ANALYSIS
# ============================================================

numeric_data <- data[sapply(data, is.numeric)]

correlation_matrix <- cor(numeric_data)

round(correlation_matrix, 2)

# Correlation of numeric predictors with Exam_Score
correlation_matrix[, "Exam_Score"]


# ============================================================
# 6. INITIAL MULTIPLE LINEAR REGRESSION MODEL
# ============================================================

model_full <- lm(
  Exam_Score ~ .,
  data = data
)

summary(model_full)


# ============================================================
# 7. MODEL ASSUMPTION CHECKS
# ============================================================

# 7.1 Multicollinearity
vif(model_full)

# 7.2 Standard regression diagnostic plots
par(mfrow = c(2, 2))
plot(model_full)
par(mfrow = c(1, 1))

# 7.3 Investigate observations with large residuals
outliers <- data[abs(residuals(model_full)) > 5, ]

nrow(outliers)
head(outliers, 20)

# These observations are investigated rather than automatically removed.
# No observations are deleted solely to improve model performance.


# ============================================================
# 8. MODEL REFINEMENT
# ============================================================

# Remove predictors that were not statistically significant
# in the initial model:
# Sleep_Hours, School_Type and Gender.

model_refined <- lm(
  Exam_Score ~
    Hours_Studied +
    Attendance +
    Parental_Involvement +
    Access_to_Resources +
    Extracurricular_Activities +
    Previous_Scores +
    Motivation_Level +
    Internet_Access +
    Tutoring_Sessions +
    Family_Income +
    Teacher_Quality +
    Peer_Influence +
    Physical_Activity +
    Learning_Disabilities +
    Parental_Education_Level +
    Distance_from_Home,
  data = data
)

summary(model_refined)

# Compare full and refined models
anova(model_refined, model_full)

# Information criteria
AIC(model_full, model_refined)
BIC(model_full, model_refined)


# ============================================================
# 9. TRAIN-TEST VALIDATION
# ============================================================

set.seed(123)

# 80% training and 20% testing
train_index <- sample(
  seq_len(nrow(data)),
  size = 0.80 * nrow(data)
)

train_data <- data[train_index, ]
test_data <- data[-train_index, ]

# Train the refined model using training data only
model_train <- lm(
  Exam_Score ~
    Hours_Studied +
    Attendance +
    Parental_Involvement +
    Access_to_Resources +
    Extracurricular_Activities +
    Previous_Scores +
    Motivation_Level +
    Internet_Access +
    Tutoring_Sessions +
    Family_Income +
    Teacher_Quality +
    Peer_Influence +
    Physical_Activity +
    Learning_Disabilities +
    Parental_Education_Level +
    Distance_from_Home,
  data = train_data
)

# Training R-squared
training_R2 <- summary(model_train)$r.squared

# Predict on unseen test data
predictions <- predict(
  model_train,
  newdata = test_data
)

actual <- test_data$Exam_Score


# ============================================================
# 10. MODEL EVALUATION
# ============================================================

# Mean Absolute Error
MAE <- mean(abs(actual - predictions))

# Mean Squared Error
MSE <- mean((actual - predictions)^2)

# Root Mean Squared Error
RMSE <- sqrt(MSE)

# Test R-squared
R2 <- 1 -
  sum((actual - predictions)^2) /
  sum((actual - mean(actual))^2)

# Display validation results
cat("\nMODEL VALIDATION RESULTS\n")
cat("------------------------\n")
cat("Training R-squared:", round(training_R2, 4), "\n")
cat("Test R-squared:    ", round(R2, 4), "\n")
cat("MAE:               ", round(MAE, 4), "\n")
cat("MSE:               ", round(MSE, 4), "\n")
cat("RMSE:              ", round(RMSE, 4), "\n")


# ============================================================
# 11. INTERPRETATION & FINAL PREDICTION
# ============================================================

# Final model coefficients
summary(model_refined)$coefficients

# 95% confidence intervals
confint(model_refined)


# ------------------------------------------------------------
# Prediction for a hypothetical student
# ------------------------------------------------------------

new_student <- data.frame(
  Hours_Studied = 25,
  Attendance = 90,
  Parental_Involvement = factor(
    "Medium",
    levels = levels(data$Parental_Involvement)
  ),
  Access_to_Resources = factor(
    "High",
    levels = levels(data$Access_to_Resources)
  ),
  Extracurricular_Activities = factor(
    "Yes",
    levels = levels(data$Extracurricular_Activities)
  ),
  Previous_Scores = 80,
  Motivation_Level = factor(
    "Medium",
    levels = levels(data$Motivation_Level)
  ),
  Internet_Access = factor(
    "Yes",
    levels = levels(data$Internet_Access)
  ),
  Tutoring_Sessions = 2,
  Family_Income = factor(
    "Medium",
    levels = levels(data$Family_Income)
  ),
  Teacher_Quality = factor(
    "Medium",
    levels = levels(data$Teacher_Quality)
  ),
  Peer_Influence = factor(
    "Positive",
    levels = levels(data$Peer_Influence)
  ),
  Physical_Activity = 3,
  Learning_Disabilities = factor(
    "No",
    levels = levels(data$Learning_Disabilities)
  ),
  Parental_Education_Level = factor(
    "College",
    levels = levels(data$Parental_Education_Level)
  ),
  Distance_from_Home = factor(
    "Near",
    levels = levels(data$Distance_from_Home)
  )
)

# Predicted exam score
predicted_score <- predict(
  model_train,
  newdata = new_student
)

cat("\nPREDICTION FOR NEW STUDENT\n")
cat("-------------------------\n")
cat("Predicted Exam Score:", round(predicted_score, 2), "\n")

# 95% prediction interval
prediction_interval <- predict(
  model_train,
  newdata = new_student,
  interval = "prediction",
  level = 0.95
)

prediction_interval


# ============================================================
# END OF PROJECT
# ============================================================
