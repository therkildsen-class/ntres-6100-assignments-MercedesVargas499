library(tidyverse)
library(gapminder)  #install.packages("gapminder")
# For being able to compare plots side by side, I'm also going to use the gridExtra package today
library(gridExtra)  #install.packages("gridExtra")


# Intro factors -----------------------------------------------------------

x1 <- c("Dec", "Apr", "Jan", "Mar")

sort(x1)

x2 <- c("Dec", "Apr", "Jam", "Mar")

month_levels<- c (
  "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

y1 <- factor(x1, levels = month_levels)
sort(y1)

y2 <- factor(x2, levels = month_levels)
sort(y2)


# Factors in plotting -----------------------------------------------------

gapminder

str(gapminder$continent)

levels(gapminder$continent)

nlevels(gapminder$continent)


gapminder |> 
  count(continent)

nlevels(gapminder$country)

h_countries <- c("Egypt", "Haiti", "Romania", "Thailand", "Venezuela")
h_gap <- gapminder |> 
  filter(country %in% h_countries)

h_gapped_dropped <- h_gap |> 
  droplevels()

nlevels(h_gapped_dropped$country)

h_gap$country |> 
  fct_drop()


small_countries <- gapminder |> 
  filter(pop < 250000)

small_countries |> 
  count(country)

small_countries <- gapminder |> 
  filter(pop < 250000) |> 
  droplevels()

small_countries <- gapminder |> 
  filter(pop < 250000) |> 
  mutate(country = fct_drop(country))
