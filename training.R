energia <- c(100, 150, 200, 220, 300, 390, 440, 490, 520, 600, 10, 30, 50, 200, 300,450, 526, 657, 746, 780)
consumo <- c(100, 120, 140, 200, 423, 510, 635, 645, 523, 745, 860,932, 230, 403, NA, 310, 390, 523, NA, NA)
costo_kwh <- c(5, 2)


#Paso 2: sustituir NA por mediana de consumo

#Obtengo vector sin NA>
consumo_filter <- na.omit(consumo)
media_consumo <- mean(consumo_filter)
consumo_tratado <- replace(consumo, is.na(consumo), media_consumo)

#print(consumo_tratado)

#Paso 3: Crear el dataframe
df <- data.frame(energia=energia, consumo=consumo_tratado, costo_kwh=costo_kwh)

#Paso 4 calculos
#Agrega una columna llamada costo_total que calcule el costo diario (consumo * costo por kWh).
df$costo_total <- df$consumo * df$costo_kwh
#Calcula el total de consumo y el costo total por cada tipo de energía (renovable y no renovable).
df$tipo_energia <- ifelse(df$energia <= 200, "Renovable", "No Renovable")
#Calcula la media del consumo diario para cada tipo de energía para analizar el consumo promedio.
total_por_tipo <- aggregate(cbind(consumo, costo_total) ~ tipo_energia, data = df, sum)
media_consumo <- aggregate(consumo ~ tipo_energia, data = df, mean)

df$ganancia <- df$costo_total * 1.1

#Paso 5 resumen
df_ordenado <- df[order(df$costo_total, decreasing = TRUE), ]
total_por_tipo <- aggregate(cbind(consumo, costo_total) ~ tipo_energia, data = df, sum)
top_3_costos <- head(df_ordenado, 3)
resumen_energia <- list(
  dataframe_ordenado = df_ordenado,  # Dataframe ordenado por costo_total
  total_por_tipo = total_por_tipo,  # Total de consumo y costo total por tipo de energía
  top_3_costos = top_3_costos  # Las tres filas con el mayor costo_total
)
