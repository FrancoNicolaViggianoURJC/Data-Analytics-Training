#1 Carga de librerias y datos
install.packages("dplyr")
library(dplyr)
install.packages("tidyr")
library(tidyr)

data(mtcars)
df <- as.data.frame(mtcars)

#2 Selección de columnas y filtrado de filas
df <- df %>% select(mpg,cyl,hp,gear)
print(df)
df <- df %>% filter(cyl>4)
print(df)

#3 Ordenación y renombrado de columnas
df <- df %>% arrange(desc(hp))
print(df)
df <- df %>% rename(consumo=mpg)
print(df)
df <- df %>% rename(potencia=hp)
print(df)

#4. Creación de nuevas columnas y agregación de datos
df <- df %>% mutate(eficiencia = consumo/potencia)
print(df)
df <- df %>% group_by(cyl) %>% summarise(consumoMedio=mean(consumo), potenciaMax=max(potencia))
print(df)

#5. Creación del segundo dataframe y unión de dataframes
df <- as.data.frame(mtcars)
print(df)
df <- df %>% select(mpg,cyl,hp,gear)
print(df)
df <- df %>% rename(consumo=mpg)
print(df)
df <- df %>% rename(potencia=hp)
print(df)
df <- df %>% mutate(eficiencia = consumo/potencia)
dfAux <- data.frame(
  gear = c(3, 4, 5),
  tipo_transmision = c("Manual", "Automática", "Semiautomática")
)
print(df)
dfFinal <- df %>% left_join(dfAux, by = "gear")
print(dfFinal)

#6. Transformación de formatos
dfFinal <- pivot_longer(dfFinal, cols = c(consumo, potencia, eficiencia), names_to = "variable", values_to = "valor")
print(dfFinal)
dfFinal <- dfFinal %>% group_by(cyl, gear, tipo_transmision)
print(dfFinal)
dfFinal <- pivot_wider(dfFinal,names_from = valor, values_from = seen)
print(dfFinal)
