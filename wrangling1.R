library (tidyverse)
#install.packages("skimr") 
#aca se usan comillas porque necesita el nombre del paquete como texto, porque lo va a buscar en CRAN (el repositorio de paquetes).
library(skimr)
coronavirus <- read_csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/refs/heads/main/csv/coronavirus.csv")
summary(coronavirus)
skim(coronavirus)
