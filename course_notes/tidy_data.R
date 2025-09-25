library(tidyverse)
table1
table2
table3
table4a
table4b

##esto es para agregar el calculo del rate
table1 |> 
  mutate(rate=cases/population*10000)


##para calcular el total de casos por año puedo usar summarize

table1 |> 
  group_by(year) |> 
  summarize(total_year=sum(cases))

##para plotear

table1 |> 
  ggplot(mapping=aes(x=year, y = cases)) +
  geom_line()

##extract the number of tb cases per country per year
##extract the matching population pero country per year
##divide cases by population and multiply by 10000
#store back in the appropiate place

table2 |> 
  group_by(year,country) |> 
  summarise(total_cases=sum())  ##aca no puedo continuar porque no hay columna cases. 
##el punto era mostrar que la tabla mal ordenada no me deja trabajar


##para ordenar las tablas tenemos que modificar las columnas y darles nombres
table4a |> 
  pivot_longer(
    cols = c("1999", "2000"),
    names_to = "year",
    values_to = "cases"
  )

##el cols = puede estar o no, funciona igual de ambas maneras
table4b |> 
  pivot_longer(
    c("1999","2000"),  ## la función c() (“combine”) crea un vector.
    names_to = "year",
    values_to = "population"
  )

##es importante saber que esto ordena, pero no guarda los datos
##si la quiero guardar (pero no es permanente, lo vemos la clase que viene):
table4b_tidy<- table4b |> 
  pivot_longer(
    c("1999","2000"),
    names_to = "year",
    values_to = "population"
  )

table2 |>  ##aca queremos que a cada linea le corresponda una observacion (cases y population a columnas)
pivot_wider(names_from = type,
            values_from = count)


##pivot_longer() → “apila” columnas → más filas, menos columnas.

##pivot_wider() → “desapila” filas → más columnas, menos filas.

table3 |>  ##en esa tabla tiene dos datos por columna (casos y poblacion incluidos en rate)
     separate(rate, ##que separamos?
              into = c("cases","population"),  ##en que lo convertimos??
              sep="/")  ##aca le decimos donde tiene que separar


table5<- table3 |> 
  separate(year,
           into= c("century", "year"),
           sep=2)

table5 |> 
  unite(fullyear,
        century,
        year,
        sep="")
