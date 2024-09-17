# packages

require(tidyverse)
require(rms)

gapminder <- read.csv('data/gapminder_data.csv')

# plot GDP vs per capita
gapminder %>%
  # filter(year == 1962) %>%
  ggplot() +
  geom_point(aes(gdpPercap, lifeExp))

xx
