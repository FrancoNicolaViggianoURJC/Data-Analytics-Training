#Variables globales
archivo <- "temperaturas.csv"
archivoOut <- "resumen_temperaturas.txt"

#Funciones
leerArchivo <- function(nombreArchivo) {
  if(file.exists(nombreArchivo)){
    csv <- read.csv(nombreArchivo)
    return(csv)
  }else{
    print("Error al leer el archivo. Se debe encontrar en la carpeta Documentos.")
    stop()
  }
}

escribirArchivo <- function(nombreArchivo, mad, bcn, vlc, max) {
  sink(nombreArchivo)
  cat("Temperaturas medias diarias por ciudad:")
  cat("\n")
  cat(paste("Madrid:", mad))
  cat("\n")
  cat(paste("Barcelona:", bcn))
  cat("\n")
  cat(paste("Valencia:", vlc))
  cat("\n")
  cat(paste("Ciudad con la temperatura media más alta del mes:", max))
  sink()
}


#Main body
  csvLeido <- leerArchivo(archivo)
  
  #Calculo de temperatura media
  csvLeido$temperatura_media <- (csvLeido$temperatura_maxima + csvLeido$temperatura_minima) / 2
  
  #Calculo de temperatura media por ciudad mensual
  mediaCiudad <- aggregate(temperatura_media ~ ciudad, data = csvLeido, FUN = mean, na.rm = TRUE)
  
  #Seleccion ciudad con mayor media
  maximo <- mediaCiudad[which.max(mediaCiudad$temperatura_media), ]
  ciudadMaxima <- maximo$ciudad
  
  #Escritura de fichero salida
  #Variables auxiliares
  mediasMadrid <- csvLeido[csvLeido$ciudad == 'Madrid',]['temperatura_media']
  mediasBarcelona <- csvLeido[csvLeido$ciudad == 'Barcelona',]['temperatura_media']
  mediasValencia <- csvLeido[csvLeido$ciudad == 'Valencia',]['temperatura_media']
  
  escribirArchivo(archivoOut, mediasMadrid,mediasBarcelona,mediasValencia,ciudadMaxima)
  
  