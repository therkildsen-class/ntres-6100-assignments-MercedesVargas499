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




