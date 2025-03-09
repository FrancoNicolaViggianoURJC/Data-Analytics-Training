# Cargar librerías necesarias
library(tseries)  # Para prueba ADF
data("AirPassengers")


# 2. Exploración inicial
plot(AirPassengers, main="Serie Temporal de AirPassengers", ylab="Pasajeros", xlab="Año")

# Cálculo de estadísticas descriptivas
mean_value <- mean(AirPassengers)
sd_value <- sd(AirPassengers)
print(paste("Media:", mean_value))
print(paste("Desviación Estándar:", sd_value))

# 3. Análisis de tendencia y estacionalidad
components <- decompose(AirPassengers)
plot(components)

# 4. Análisis de estacionariedad
acf(AirPassengers, main="ACF de AirPassengers")
pacf(AirPassengers, main="PACF de AirPassengers")

# Prueba de Dickey-Fuller
adf_test <- adf.test(AirPassengers)
print(adf_test)

# Si la serie no es estacionaria, diferenciamos
if (adf_test$p.value > 0.05) {
  diff_series <- diff(AirPassengers)
  plot(diff_series, main="Serie Diferenciada", ylab="Diferencias", xlab="Año")
  adf_test_diff <- adf.test(diff_series)
  print(adf_test_diff)
}

# 5. Detección de valores atípicos
boxplot(AirPassengers, main="Boxplot de AirPassengers", ylab="Pasajeros")

# 6. Interpretación de resultados
cat("\nResumen:\n")
cat("La serie muestra una tendencia creciente, indicando un aumento en la cantidad de pasajeros a lo largo del tiempo.\n")

