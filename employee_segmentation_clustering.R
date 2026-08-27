# ==============================================================================
# Workforce Segmentation: Hierarchical & K-Means Clustering
# ==============================================================================

# 1. Setup & Package Management ------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(readxl, dplyr)

# 2. Data Ingestion ------------------------------------------------------------
file_name <- "workforce_attrition_sample.xlsx"

if (file.exists(file_name)) {
  df <- read_excel(file_name)
} else if (file.exists(file.path("..", file_name))) {
  df <- read_excel(file.path("..", file_name))
} else {
  stop(paste("Could not find", file_name, "in current or parent directory."))
}

# Standardize column headers (trim whitespace)
names(df) <- trimws(names(df))

# 3. Numeric Standardization for Clustering ------------------------------------
# Select numeric features for distance-based clustering
numeric_cols <- df %>% select(where(is.numeric))
df_scaled <- scale(numeric_cols)

# 4. Hierarchical Clustering (Ward's Method) -----------------------------------
dist_matrix <- dist(df_scaled, method = "euclidean")
hclust_model <- hclust(dist_matrix, method = "ward.D2")

# Plot dendrogram
plot(hclust_model, main = "Employee Cluster Dendrogram (Ward's Method)", xlab = "Observations", sub = "")
abline(h = 3600, lty = 2, col = "red")

# Cut dendrogram into 4 distinct groups
cluster_groups_hclust <- cutree(hclust_model, k = 4)

# 5. K-Means Clustering (k = 4) ------------------------------------------------
set.seed(88)
kmc_model <- kmeans(df_scaled, centers = 4, iter.max = 1000)

# 6. Cluster Profiling & Summary Table -----------------------------------------
df_cluster_summary <- data.frame(
  Cluster = 1:4,
  Headcount = kmc_model$size,
  Avg_Compa_Ratio = round(tapply(df$`Compa Ratio`, cluster_groups_hclust, mean, na.rm = TRUE), 4),
  Avg_Tenure = round(tapply(df$`Tenure`, cluster_groups_hclust, mean, na.rm = TRUE), 1),
  Avg_Base_Pay_Annualized = round(tapply(df$`Base Pay Mid Point Annualized`, cluster_groups_hclust, mean, na.rm = TRUE)),
  Avg_Cost_to_Replace_Multiplier = round(tapply(df$`Cost to Replace Employee Multiplier`, cluster_groups_hclust, mean, na.rm = TRUE), 4)
)

print("--- Cluster Cohort Summary ---")
print(df_cluster_summary)
