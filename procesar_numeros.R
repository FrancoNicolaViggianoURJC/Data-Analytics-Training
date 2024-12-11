
#Lectura fichero entrada
leer_numeros <- function(nombreArchivo) {
  if(file.exists(nombreArchivo)){
    numeros <- scan(nombreArchivo, what = numeric())
    return(numeros)
  }else{
    print("Error al leer el archivo. Se debe encontrar en la carpeta Documentos.")
    stop()
  }
}
fichEntrada <- "./numeros.txt"
numeros <-leer_numeros(fichEntrada)

#Estadisticas
media <- mean(numeros)
mediana <- median(numeros)
desviacionEstandar <- round( sd(numeros), digits=3)

#Valores atipicos
if(desviacionEstandar > 10){
  print(paste("Hay alta variabilidad en los datos; SD de: ",  desviacionEstandar))
}

#Vector cuadrados
elevarCuadrado <- function(x){
  return(x*x)
}

cuadrados <- sapply(numeros, elevarCuadrado)

#Escritura resultados
  #Preprocesamiento
  estadisticasToString <- c(
    paste("Media:", media),
    paste("Mediana:", mediana),
    paste("Desviación estándar:", desviacionEstandar)
  )
  cuadradosTexto <- paste("Cuadrados:", cuadrados, collapse = "\n")
  
  archOut<-file("numerosSalida.txt")
  writeLines(c(estadisticasToString, cuadradosTexto), archOut)
  close(archOut)
