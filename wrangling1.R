library (tidyverse)
#install.packages("skimr") 
#aca se usan comillas porque necesita el nombre del paquete como texto, porque lo va a buscar en CRAN (el repositorio de paquetes).
library(skimr)

coronavirus <- read_csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/refs/heads/main/csv/coronavirus.csv")
summary(coronavirus)
skim(coronavirus)
view(coronavirus)
head(coronavirus)
tail(coronavirus)

coronavirus$cases #esto me ayuda a ver un atributo
#podemos usar las anteriores sobre esto:
head(coronavirus$cases)

?filter

# cases > 0 el nombre de la variable va sin $ y sin ""
filter(coronavirus, cases > 0)

#aca se ponen dos == porque un solo = le asigna un valor, aca queremos
#que sea un argumento logico, de que es igual a 
filter(coronavirus, country == "US")
# US va con "" porque es una variable de texto
#ahora si quiero decir es diferente a se usa != (para ver los que no son US)
filter(coronavirus, country != "US")

coronavirus_us <-filter(coronavirus, country == "US")
# <- se usa para asignar un valor o resultado a un objeto. 
#Es decir, le decís a R: “guarda esto con este nombre”.

filter(coronavirus, country == "US"| country == "Canada")
# | significa "o", o sea us o canada

filter(coronavirus, country == "US" & type == "death")
# & se usa para tener dos filtros que actuen al mismo tiempo (igual que poner ,)
filter(coronavirus, country == "US", type == "death")

filter(coronavirus, country == c("US", "Canada")) 
filter(coronavirus, country %in% c("US", "Canada")) 
#esto es para incluir o guardar todos los valores que tengan uno o el otro

filter(coronavirus,type == "death", country %in% c("Denmark", "Italy", "Spain"), date == "2021-09-16" )

view (count(coronavirus, country))
select(coronavirus, type, date)
select(coronavirus,country, lat, long)
select(coronavirus, 1:3) #esto indica que quiero seleccionar las primeras 3 columnas
select(coronavirus, date:cases) #aca te selecciona desde la columna date a la columna cases

