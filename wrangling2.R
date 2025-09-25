library(tidyverse)
library(skimr)
coronavirus <- read_csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/refs/heads/main/csv/coronavirus.csv")

head(coronavirus,10)

##Dos formas de hacer este filtering:
  
table(
  select(
    filter(coronavirus,type == "confirmed", lat > 60),
    country
  )
)

## el simbolo |> (pipe operator)Se lee como “pásale el resultado de la 
##izquierda como primer argumento a la función de la derecha”.

coronavirus |> 
  filter(lat > 60, type == "confirmed") |> 
  select(country) |> 
  table()
##filter(lat > 60, type == "confirmed")
##Te quedás solo con las filas de países con latitud > 60°y con casos 
##confirmados.
##select(country) Quitás todas las columnas menos country. 
##Ahora tenés una sola columna con los nombres de los países.
##table() Cuenta cuántas veces aparece cada país en esa columna 
##→ es decir, cuántas filas había para ese país después del filtrado


##si quisiera contar el numero de casos por pais:
coronavirus |> 
  filter(lat > 60, type == "confirmed") |> 
  group_by(country) |>
  summarise(total_cases = sum(cases, na.rm=TRUE))

##summarise(...) Crea un nuevo data frame resumido.
##Cada grupo definido por group_by() se reduce a una fila.
##Dentro de los paréntesis ponés cómo querés resumir los datos.
##total_cases = ...
##Define el nombre de la nueva columna en la tabla resultante
##en este caso "total_cases".
##sum(cases, na.rm = TRUE) Aplica la función sum() sobre la columna cases.
## na.rm = TRUE significa “remover los NA” 
##ignora los valores faltantes para que no arruinen la suma.

coronavirus|>
  count(country)|>
  view()

coronavirus|>
  filter(type == "death",country %in% c("Canada","US","Mexico" ))|>
  select(cases,country,date)|>
  ggplot() + 
  geom_line(mapping = aes(x=date, y=cases, color=country))
  

coronavirus |>
  filter(type == "death", country %in% c("Canada","US","Mexico")) |>
  group_by(country) |>
  summarise(total_cases = sum(cases, na.rm = TRUE)) |>
  ggplot(aes(x = total_cases, y = country, color=country)) +
  geom_col()



vacc <- read_csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/main/csv/covid19_vaccine.csv")
View(vacc)
vacc|> 
  filter(date==max(date))|>
  select(country_region,continent_name, people_at_least_one_dose,population)|>
  mutate(vaxxrate=people_at_least_one_dose/population,1)|>
  view()

    
vacc|> 
  group_by(country_region) |>
  summarise(
    total_country = sum(doses_admin, na.rm = TRUE),
    total_vaxxed = sum(people_at_least_one_dose, na.rm = TRUE)
  ) |>
  filter(total_country > 200000000) |>
  mutate(doses_per_vaxxed = total_country / total_vaxxed)|>
  filter(doses_per_vaxxed>3)




vacc |> 
filter(date == max(vacc$date)) |> 
select(country_region, continent_name, people_at_least_one_dose, population) |> 
mutate(vaxxrate = round(people_at_least_one_dose / population, 2)) |> 
arrange(-vaxxrate) |> 
filter(vaxxrate > 0.9)



# Summarize function ------------------------------------------------------

coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv')
coronavirus |> 
  filter(type=="confirmed") |> 
  group_by(country) |> 
  ##esto me agrupa por paises, o sea quiero resumen por país de un determinado 
  ##dato que pido después
  summarise(sum=sum(cases),
##summarize(sum=mean(cases),
  n=n())|> 
##puedo hacer suma, media etc, según la función que quiera correr.
##sum es el nombre que se le da a la funcion de summarise 
##(podria ser cualquier otro nombre)
arrange(-sum) ##eso es para ordenar de mayor a menor


coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv')
coronavirus |> 
  group_by(date,type) |> 
  summarise(sum=sum(cases)) |> 
  filter(date=="2023-01-01")

coronavirus |> 
  filter(type=="death") |> 
  group_by(date) |> 
  summarise(total_death=sum(cases, na.rm = TRUE))|> ##se usa cases para sum porque es la columna, no el valor
  arrange(-total_death)

gg_base <- coronavirus |> 
  filter(type=="confirmed") |> 
  group_by(date) |> 
  summarise(total_cases=sum(cases)) |>
  ggplot(mapping = aes(x=date,y=total_cases))

gg_base +
  geom_line()

gg_base +
  geom_point()

gg_base +
  geom_area(fill="red")

gg_base +
  geom_line(
    color="purple",
    linetype="dashed"
  )

gg_base +
  geom_point(
             color="purple",
             shape= 17,
             size=4,
             alpha=0.5 ##esto da la transparencia, mientras mas chico mas transparente
  )

gg_base +
  geom_point(mapping=aes(size=total_cases, color=total_cases),
      alpha=0.5 
  ) +
  theme_minimal()+
  theme(legend.background=element_rect(
    fill = "lemonchiffon",
    color = "grey50",
    linewidth = 1
  ))

##si quiero eliminar la leyenda: 
gg_base +
  geom_point(mapping=aes(size=total_cases, color=total_cases),
             alpha=0.5 
  ) +
  theme_minimal()+
  theme(legend.position = "none")


gg_base +
  geom_point(mapping=aes(size=total_cases, color=total_cases),
             alpha=0.5 
  ) +
  theme_minimal()+
  labs(
    x="Date",
    y="Total confirmed cases",
    title= str_c("Daily counts of new coronavirus cases ", max(coronavirus$date)),
    subtitle= "Global sums"
  )

##srt_c sirve para unir texto a una funcion y que siga en el titulo por ej si los datos cambian.

coronavirus |> 
  filter(type=="confirmed") |> 
  group_by(date,country) |> 
  summarise(total_daily_count=sum(cases)) |> 
  arrange(-total_daily_count) |> 
  ggplot()+
  geom_line(mapping = aes(x=date,y=total_daily_count))

## aca se agrega top5_countries con <- para darle nombre a todo el codigo  
top5_countries <- coronavirus |> 
  filter(type=="confirmed") |> 
  group_by(country) |> 
  summarise(total_daily_count=sum(cases)) |> 
  arrange(-total_daily_count) |> 
  head(5) |> 
  pull(country)


## ahora quiero excluir algo de datos que no es para los 5 paises que salen del
##codigo anterior
coronavirus |> 
  filter(type=="confirmed", country %in% top5_countries ) |> 
  group_by(date,country) |> 
  summarise(total_daily_count=sum(cases)) |> 
  arrange(-total_daily_count) |> 
  ggplot()+
  geom_line(mapping = aes(x=date,y=total_daily_count, color = country))

## aca quiero que los casos sean mayor a 0
coronavirus |> 
  filter(type=="confirmed", country %in% top5_countries, cases >= 0 ) |> 
  group_by(date,country) |> 
  summarise(total_daily_count=sum(cases)) |> 
  arrange(-total_daily_count) |> 
  ggplot()+
  geom_line(mapping = aes(x=date,y=total_daily_count, color = country))


## aca quiero separar los graficos por pais
coronavirus |> 
  filter(type=="confirmed", country %in% top5_countries, cases >= 0 ) |> 
  group_by(date,country) |> 
  summarise(total_daily_count=sum(cases)) |> 
  arrange(-total_daily_count) |> 
  ggplot()+
  geom_line(mapping = aes(x=date,y=total_daily_count, color = country)) +
  facet_wrap(~country, ncol(1))


