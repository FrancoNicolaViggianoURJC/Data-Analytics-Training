dataset <- read.csv("dataset.csv")
head(dataset)

# 2. Exploración y limpieza de datos
dim(dataset)
str(dataset)
summary(dataset)

# Renombrar columnas
colnames(dataset) <- c("ID", "Genre", "Age", "Annual_Income", "Spending_Score")

# Codificar Genre como variable numérica
dataset$Genre <- ifelse(dataset$Genre == "Male", 1, 0)

# Normalizar variables numéricas
dataset[, c("Annual_Income", "Spending_Score")] <- scale(dataset[, c("Annual_Income", "Spending_Score")])

# 3. Exploración de variables
hist(dataset$Age, main="Distribución de Edad", col="blue")
boxplot(dataset$Annual_Income, main="Boxplot de Ingreso Anual", col="red")
boxplot(dataset$Spending_Score, main="Boxplot de Spending Score", col="green")

# 4. Entrenamiento de modelos de clustering
library(cluster)

# K-Means
wss <- sapply(2:6, function(k){
  kmeans(dataset[, c("Annual_Income", "Spending_Score")], centers=k, nstart=25)$tot.withinss
})
plot(2:6, wss, type="b", main="Método del Codo", xlab="Número de Clusters", ylab="WSS")

k_optimo <- 4  # Ajusta según el codo identificado
kmeans_model <- kmeans(dataset[, c("Annual_Income", "Spending_Score")], centers=k_optimo, nstart=25)
dataset$Cluster_KMeans <- as.factor(kmeans_model$cluster)

# Clustering Jerárquico
dist_matrix <- dist(dataset[, c("Annual_Income", "Spending_Score")], method = "euclidean")
hclust_model <- hclust(dist_matrix, method = "ward.D")
plot(hclust_model, main="Dendrograma")
rect.hclust(hclust_model, k=k_optimo, border="red")
dataset$Cluster_Hierarchical <- as.factor(cutree(hclust_model, k=k_optimo))

# 5. Evaluación de modelos
sil_kmeans <- silhouette(kmeans_model$cluster, dist_matrix)
mean(sil_kmeans[, 3])

sil_hierarchical <- silhouette(cutree(hclust_model, k=k_optimo), dist_matrix)
mean(sil_hierarchical[, 3])

# 6. Análisis descriptivo de segmentos
aggregate(dataset[, c("Age", "Annual_Income", "Spending_Score")], by=list(Cluster=dataset$Cluster_KMeans), FUN=mean)


# Guardar resultados
write.csv(dataset, "dataset_segmentado.csv", row.names=FALSE)
