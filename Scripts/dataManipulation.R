require(tidyverse)


gapminder = read.csv('data/gapminder_data.csv')

yearCountry = gapminder %>%
  filter(continent == 'Europe') %>%
  select(year, country, gdpPercap)


europeLifeExp_2007 = gapminder %>%
  filter(continent == 'Europe',
         year == 2007) %>%
  select(year, country, gdpPercap)



europeLifeExp_2007 = gapminder %>%
  filter(continent == 'Europe',
         year %in% c(2007,2008)) %>%
  select(year, country, gdpPercap)



Africa = gapminder %>%
  filter(continent == 'Africa') %>%
  select(lifeExp, country, year)




gapminder %>%
  filter(continent == 'Africa') %>%
  select(lifeExp, country, year) 
