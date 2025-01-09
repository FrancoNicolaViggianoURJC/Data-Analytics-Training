---
title: "Análisis Exploratorio del Dataset `mtcars`"
author: "Tu Nombre"
output:
  html_document:
    theme: readable
    toc: true
    toc_depth: 2
---

# Introducción

El propósito de este documento es realizar un **análisis exploratorio** del dataset `mtcars` en R. Este conjunto de datos contiene información sobre características de diferentes modelos de automóviles y será utilizado para demostrar capacidades de visualización y tabulación en R Markdown.

**Puntos clave:**

1. Descripción general de los datos.
2. Creación de tablas estáticas e interactivas.
3. Visualización gráfica de datos relevantes.
4. Resumen de hallazgos principales.

# Carga de datos

Primero, cargamos el dataset `mtcars` disponible en R:

```{r load-data, message=FALSE}
library(dplyr)
library(knitr)
library(DT)
data("mtcars")
head(mtcars)
```

# Análisis de datos

## Tabla estática
```{r kable-table}
kable(head(mtcars, 10), caption = "Primeras 10 filas del dataset `mtcars`.")
```

## Tabla interactiva

```{r dt-table}
datatable(mtcars, options = list(pageLength = 5),
          caption = "Tabla interactiva del dataset `mtcars`.")
```

## Gráfico

Para visualizar la relación entre el peso del automóvil (`wt`) y el consumo de combustible (`mpg`), generamos un gráfico de dispersión:

```{r scatter-plot, echo=FALSE}
library(ggplot2)
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point(color = "blue", size = 3) +
  labs(
    title = "Relación entre peso y consumo de combustible",
    x = "Peso (1000 lbs)",
    y = "Millas por galón (mpg)"
  ) +
  theme_minimal()
```
