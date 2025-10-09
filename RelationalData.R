library(tidyverse)
library(nycflights13)  # install.packages("nycflights13")


fship <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")

ttow <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv")

rking <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")

view(fship)
view(ttow)
view(rking)

##quiero unirlas (aca es facil porque estan estructuradas igual)

lotr <- bind_rows(fship, rking, ttow)
view(lotr)


fship_no_female <- fship |> 
  select(-Female)

lotr1 <- bind_rows(fship_no_female, rking, ttow)
view(lotr1)


fship_shuffled <- fship |> 
  select(Male, Film, Race)  ##this will work the same, as long as it can match the variable names, the joining will work



# Join functions ----------------------------------------------------------


##if we want to add a column that is from a different table: 

flights
airlines
airports

planes |> 
  count(year) |> 
  tail()

planes |> 
  count(tailnum) |>   # cuenta cuántas veces aparece cada tailnum
  filter(n > 1) |>    # se queda solo con los tailnum que aparecen más de una vez
  head()              # muestra las primeras 6 filas


weather |> 
  count(time_hour, origin) |> 
  filter(n > 1)

planes |> 
  filter(is.na(tailnum)) ##para cada valor de tailnum me da true o false


flights2 <- flights |> 
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2

flights2 |> 
  left_join(airlines)  ##aca une los nombres de variables que sean iguales 

flights2 |> 
  left_join(weather)

flights2 |> 
  left_join(planes)  ##da muchos valores con NA porque la variable years significa cosas diferentes


flights2 |> 
  left_join(planes, join_by(tailnum)) ##aca le aclaro que quiero usar para unirlos

flights2 |> 
  left_join(planes, 
            join_by(tailnum),
            suffix = c("_flights", "_planes"))

flights2 |> 
  left_join(airports, 
            join_by(origin == faa))
airports2 <- airports |> 
  select(faa, name, lat, lon)

flights2 |> 
left_join(airports2, join_by(origin == faa)) |> 
  left_join(airports2,join_by(dest == faa),
            suffix = c("_origin", "dest"))

airports |> 
  semi_join(flights2, join_by(faa == origin))

##esto cuenta los destinos
flights2 |> 
  anti_join(airports, join_by(dest == faa)) |> 
  count(dest)

##esto nos da el valor unico de la variable
flights2 |> 
  anti_join(airports, join_by(dest == faa)) |> 
  distinct(dest)

planes_gt100 <- flights2 |>
  count(tailnum) |> 
  filter(n>100)

planes_gt100 <- flights2 |> 
  group_by(tailnum) |> 
  summarize(counttail = n()) |> 
  filter(counttail > 100)

flights2 |> 
  semi_join(planes_gt100)