# Cargar librerías necesarias
library(tseries)  # Para prueba ADF
data("nottem")

# Graficar la serie temporal
plot(nottem, main="Temperaturas Mensuales en Nottingham", 
     xlab="Año", ylab="Temperatura", col="blue")

# 2. Exploración y preparación de datos
components <- decompose(nottem)
plot(components)

acf(nottem, main="ACF de nottem")
pacf(nottem, main="PACF de nottem")

adf_test <- adf.test(nottem)

# 4. Transformación de la serie (si es necesario)
if (adf_test$p.value > 0.05) {
  diff_series <- diff(nottem)
  plot(diff_series, main="Serie Diferenciada", ylab="Diferencias", xlab="Año")
}

