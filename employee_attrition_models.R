# ==============================================================================
# Workforce Attrition & Headcount Forecasting
# ==============================================================================

# 1. Package Management & Setup ------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(
  readxl,
  tidyverse,
  tidymodels,
  caret,
  recipes,
  tree,
  rpart,
  rpart.plot,
  C50,
  ROCR,
  pROC,
  PRROC,
  forecast
)

# 2. Data Ingestion & Preprocessing --------------------------------------------
file_name <- "workforce_attrition_sample.xlsx"

if (file.exists(file_name)) {
  df <- read_excel(file_name)
} else if (file.exists(file.path("..", file_name))) {
  df <- read_excel(file.path("..", file_name))
} else {
  stop(paste("Could not find", file_name, "in current or parent directory."))
}

# Clean column headers: trim trailing whitespace and replace spaces with underscores
names(df) <- trimws(names(df))
names(df) <- gsub(" ", "_", names(df))

# Standardize Base Pay Mid Point to USD
df$Base_Mid_Point_Converted <- df$Base_Pay_Mid_Point_Annualized * df$Currency_Conversion_Rate

# 3. Binary Classification Dataset Preparation ---------------------------------
# Objective: Identify attributes predicting voluntary employee departure
df_binary <- subset(
  df,
  select = c(
    "Termination_Type",
    "Compa_Ratio", 
    "Base_Mid_Point_Converted",
    "Job_Category",
    "Work_Country", 
    "Gender", 
    "Tenure_Bucket", 
    "Generation", 
    "Work_Structure"
  )
)

# Encode binary target (1 = Voluntary Termination, 0 = Other / Active)
df_binary$Termination_Type <- ifelse(df_binary$Termination_Type == "Voluntary Termination", 1, 0)
df_binary$Termination_Type[is.na(df_binary$Termination_Type)] <- 0
df_binary$Work_Structure[is.na(df_binary$Work_Structure)] <- "Onsite"

# Dummy encode categorical predictors
dmy <- dummyVars(" ~ .", data = df_binary)
df_binary <- data.frame(predict(dmy, newdata = df_binary))

# 4. Model Training & Evaluation (70/30 Split) ----------------------------------
set.seed(622)
indexes <- sample(nrow(df_binary), 0.7 * nrow(df_binary), replace = FALSE)
train <- df_binary[indexes, ]
test  <- df_binary[-indexes, ]

# Preprocessing recipe
rec <- recipe(Termination_Type ~ ., data = df_binary) %>%
  step_other(all_nominal_predictors()) %>%
  prep()

train <- bake(rec, new_data = train)
test  <- bake(rec, new_data = test)

# Model A: Standard Decision Tree (`tree`)
tree_model <- tree(as.factor(Termination_Type) ~ ., data = train, na.action = na.exclude, method = "class")
plot(tree_model)
text(tree_model, pretty = 0, cex = 0.7)

tree_pred_prob <- predict(tree_model, test, type = "vector")[, 2]
tree_pred_class <- predict(tree_model, test, type = "class")
ct_tree <- table(Actual = test$Termination_Type, Predicted = tree_pred_class)
print("--- Tree Model Confusion Matrix ---")
print(ct_tree)

# Model B: Recursive Partitioning (`rpart`)
rpart_model <- rpart(as.factor(Termination_Type) ~ ., data = train, na.action = na.exclude, method = "class")
rpart.plot(rpart_model)
plotcp(rpart_model)

rpart_pred_prob <- predict(rpart_model, test, type = "prob")[, 2]
rpart_pred_class <- predict(rpart_model, test, type = "class")
ct_rpart <- table(Actual = test$Termination_Type, Predicted = rpart_pred_class)
print("--- Rpart Model Confusion Matrix ---")
print(ct_rpart)

# Model C: C5.0 Decision Tree & Variable Importance
c50_model <- C5.0(as.factor(Termination_Type) ~ ., data = train)
print(summary(c50_model))
print(C5imp(c50_model))

c50_pred_prob <- predict(c50_model, test, type = "prob")[, 2]
c50_pred_class <- predict(c50_model, test, type = "class")
ct_c50 <- table(Actual = test$Termination_Type, Predicted = c50_pred_class)
print("--- C5.0 Model Confusion Matrix ---")
print(ct_c50)

# 5. Time-Series Headcount Forecasting -----------------------------------------
# Objective: Forecast monthly termination volume to support hiring plans
df_regr <- subset(
  df,
  select = c(
    "Termination_Date", 
    "Employee_Status", 
    "Termination_Type"
  )
)

df_regr$Employee_Status <- ifelse(df_regr$Employee_Status == "Terminated", 1, 0)
df_regr <- df_regr[df_regr$Employee_Status == 1 & !is.na(df_regr$Termination_Date), ]
df_regr$Termination_Date <- as.Date(df_regr$Termination_Date, format = "%Y-%m-%d")

# Tabulate monthly exit frequencies
tab <- table(cut(df_regr$Termination_Date, "month"))
df_regr_count <- data.frame(
  Termination_Date = format(as.Date(names(tab)), "%m/%Y"),
  Frequency = as.vector(tab)
)

# Fit Auto-ARIMA Model
start_year <- as.numeric(format(min(df_regr$Termination_Date, na.rm = TRUE), "%Y"))
ts_df <- ts(df_regr_count$Frequency, start = c(start_year, 1), frequency = 12)

plot(ts_df, main = "Historical Monthly Employee Terminations", ylab = "Exits", xlab = "Year")
arima_model <- auto.arima(ts_df)
headcount_forecast <- forecast(arima_model, level = c(95), h = 24)

plot(headcount_forecast, main = "24-Month Headcount Exit Forecast (95% CI)", ylab = "Projected Exits", xlab = "Year")
summary(arima_model)
