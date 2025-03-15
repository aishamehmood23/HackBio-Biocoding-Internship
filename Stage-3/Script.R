#### Stage-3 ####

# Install & Load required packages
# run this once only
install.packages("tidyverse")
install.packages("factoextra") 
install.packages("cluster")
install.packages("gridExtra")
install.packages("ggalt")  

# load the libraries
library(tidyverse)   # For data manipulation and visualization
library(factoextra)  # For PCA visualization and clustering evaluation
library(cluster)# For clustering algorithms like K-Means
library(gridExtra)
library(ggalt)

# Import data
urL <- "https://raw.githubusercontent.com/PacktPublishing/Machine-Learning-in-Biotechnology-and-Life-Sciences/refs/heads/main/datasets/dataset_wisc_sd.csv"
data_cancer <- read.csv(urL, header = TRUE, sep = ",")

# Inspect data
View(data_cancer)
head(data_cancer)
str(data_cancer)
summary(data_cancer)
unique(data_cancer$diagnosis)

# check missing values
sum(is.na(data_cancer))

# Data pre-processsing
data_cancer$concave.points_worst <- as.numeric(data_cancer$concave.points_worst) # the column "concave.points_worst" contains numbers and needs to be converted to numeric type
data_cancer_preprocessed <- na.omit(data_cancer) #removes rows with NA values
data_cancer_preprocessed$diagnosis <- as.factor(data_cancer_preprocessed$diagnosis)

# Separate features(independent variables) and target(dependent variable)
features <- data_cancer_preprocessed %>% select(-diagnosis, -id)  # Removes the columns "ID" and "Diagnosis"
target <- data_cancer_preprocessed$diagnosis

#Standardize the data
data_cancer_scaled <- scale(features)

#PCA
pca_result <- prcomp(data_cancer_scaled, center = TRUE, scale. = TRUE)

# Visualize PCA variance explained
fviz_eig(pca_result)

# Plot the first 2 components
fviz_pca_ind(pca_result,
             col.ind = target,  # Color points by diagnosis
             palette = c("#00AFBB", "#E7B800"),
             addEllipses = TRUE, 
             title = "PCA: Benign vs Malignant",
             legend.title = "Diagnosis",
             label = "none")

# K-means clustering with K = 2
set.seed(123)  # For reproducibility
kmeans_result <- kmeans(data_cancer_scaled, centers = 2, nstart = 25)

# Visualize Clusters
fviz_cluster(kmeans_result, data = data_cancer_scaled, 
             geom = "point", ellipse.type = "norm",
             title = "K-means Clustering (K = 2)",
             ggtheme = theme_minimal())

# Determine optimal number of clusters using the Elbow Method
wss <- numeric(10)  # Create an empty vector to store WSS values
for (k in 1:10) {
  kmeans_result_wss <- kmeans(data_cancer_scaled, centers = k, nstart = 25)
  wss[k] <- kmeans_result_wss$tot.withinss  # Store WSS for each k
}

print(wss) # The rate of decrease slows down between k = 4 and k = 5. This is where the WSS reduction becomes less steep, indicating the point where adding more clusters doesn't result in a significant improvement

# Plot the WSS (within-cluster sum of squares)
plot(1:10, wss, type = "b", pch = 19, frame = TRUE, 
     xlab = "Number of clusters", ylab = "Within-cluster sum of squares")

# Run K-Means clustering with k = 4 (as determined by elbow method)
kmeans_result_K4 <- kmeans(data_cancer_scaled, centers = 4, nstart = 25)  # Change centers to 5 if needed

# View K-means cluster assignment
kmeans_result_K4$cluster

# Compare PCA and K-Means Results:
# Create a data frame with PCA results and K-means cluster assignments
pca_data <- data.frame(pca_result$x)
pca_data$kmeans_cluster <- as.factor(kmeans_result_K4$cluster)
pca_data$diagnosis <- data_cancer_preprocessed$diagnosis

# Visualize comparison: PCA and K-Means clustering
pca_vs_kmeans_plot <- ggplot(pca_data, aes(x = PC1, y = PC2, color = kmeans_cluster, shape = kmeans_cluster)) +
  # Add ellipses around clusters
  stat_ellipse(geom = "polygon", alpha = 0.2, aes(fill = kmeans_cluster), show.legend = FALSE) +
  geom_point(size = 2.6, alpha = 0.8) +  # Bigger points for visibility
  labs(title = "PCA vs K-Means Clusters", x = "Principal Component 1", y = "Principal Component 2") +
  scale_color_manual(values = c("#E41A1C", "#377EB8", "#4DAF4A", "#FF7F00")) +  # High-contrast colors
  scale_fill_manual(values = c("#E41A1C", "#377EB8", "#4DAF4A", "#FF7F00")) +  # Same colors for ellipses
  scale_shape_manual(values = c(15, 16, 17, 18)) +  # Different shapes
  theme_minimal() 

print(pca_vs_kmeans_plot)

# Compare K-Means clusters with actual diagnosis
comparison_table <- table(pca_data$diagnosis, pca_data$kmeans_cluster)
print(comparison_table)
