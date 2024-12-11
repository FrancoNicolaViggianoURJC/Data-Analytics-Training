leerArchivo <- function(nombreArchivo) { # create a function with the name my_function
  if(file.exists(nombreArchivo)){
    numeros <- scan(nombreArchivo, what = numeric())
    return(numeros)
  }else{
    print("Error reading file. Make sure its is stored in the same directory as the script.")
    stop()
  }
}

getwd()
numeros <-leerArchivo("./numeros.txt")

