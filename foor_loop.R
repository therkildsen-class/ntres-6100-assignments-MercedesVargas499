library(tidyverse)
library(gapminder)

cntry <- "Afghanistan"
country_list <- c("Albania", "Canada", "Spain")


country_list <- unique(gapminder$country)
length(country_list)


dir.create("figures")

for (cntry in country_list) {
  


gap_to_plot <- gapminder |> 
  filter(country == cntry)

my_plot <- ggplot(data = gap_to_plot, mapping = aes(x = year, y= gdp_per_cap)) +
  geom_point() +
  labs(title = str_c(cntry, "GDP per cap", sep = " "))

ggsave(filename = str_c("figures/", cntry, "_gdp_per_cap.png", sep = ""), plot = my_plot)
}




##si quisiera hcaerlo para solo europa:
  
  gap_europe <- gapminder |> 
  filter(continent == "Europe")

country_list <- unique(gap_europe$country)
length(country_list)


for (cntry in country_list) {
  
  
    gap_to_plot <- gapminder |> 
    filter(country == cntry)
  
  my_plot <- ggplot(data = gap_to_plot, mapping = aes(x = year, y= gdp_per_cap)) +
    geom_point() +
    labs(title = str_c(cntry, "GDP per cap", sep = " "))
  
  ggsave(filename = str_c("figures/", cntry, "_gdp_per_cap.png", sep = ""), plot = my_plot)
}