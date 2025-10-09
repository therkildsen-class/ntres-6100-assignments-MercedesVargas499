library(tidyverse)
##install.packages("readxl")
library(readxl)
##install.packages("googlesheets4")
library("googlesheets4")
lotr <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/lotr_tidy.csv")
head(lotr)
#install.packages("janitor")
library(janitor)
write_csv(lotr, file = "data/lotr.csv")

lotr <- read_csv("data/lotr.csv")

##Si quisiera ignorar alguna linea puedo usar 
lotr <- read_csv("data/lotr.csv", skip = 1)


##tambien si agrego comentarios puedo decir: los comentarios empiezan con #, entonces 
##esa funcion te dice cuando veas un # es un comentario.
lotr <- read_csv("data/lotr.csv", comment = "#")

lotr_excel <- read_xlsx("data/data_lesson11.xlsx")
##the default behaviour is to grab the first tab on the file
##Para que lea una hoja especifica usamos sheet = nombre de la hoja

lotr_excel <- read_xlsx("data/data_lesson11.xlsx", sheet = "FOTR")

lotr_google <- read_sheet("https://docs.google.com/spreadsheets/d/1X98JobRtA3JGBFacs_JSjiX-4DPQ0vZYtNl_ozqF6IE/edit?gid=90348395#gid=90348395")

gs4_deauth() ##esto me permite evitar tener que iniciar sesion 

lotr_google <- read_sheet("https://docs.google.com/spreadsheets/d/1X98JobRtA3JGBFacs_JSjiX-4DPQ0vZYtNl_ozqF6IE/edit?gid=90348395#gid=90348395", sheet = "deaths", range = "A5:F15") |> 
  View()


msa <- read_tsv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/main/datasets/janitor_mymsa_subset.txt") |> 
  view()

colnames(msa)
##esto es para ver los nombres de la tabla separados por _ para que sea mas facil leerlos
msa_clean <- clean_names(msa) |> 
  view()

##esto es para unirlos con mayusculas
msa_clean <- clean_names(msa, case = "upper_camel") |> 
  view()

##There are many other case options in clean_names(), like:
  
##“snake” produces snake_case (the default)
##“lower_camel” or “small_camel” produces lowerCamel
##“upper_camel” or “big_camel” produces UpperCamel
##“screaming_snake” or “all_caps” produces ALL_CAPS
##“lower_upper” produces lowerUPPER
##“upper_lower” produces UPPERlower


parse_number("$100") ## esto saca los valores no numéricos

parse_double("1,23", locale = locale(decimal_mark = ",")) ##esto es para avisar que el numero decimal se indica con , y te lo pasa a .

parse_number("123,456,789", locale = locale(grouping_mark = ","))



mess = read_tsv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/refs/heads/main/datasets/messy_data.tsv", locale = locale(decimal_mark = ","))
view(mess)

mess <- read_tsv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/refs/heads/main/datasets/messy_data.tsv",
                 col_types = cols(.default = "c"),
                 locale = locale(decimal_mark = ","),
                 na = c("Missing", "N/A")) 

view(mess)

