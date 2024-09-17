# packages

require(tidyverse)
require(rms)

gapminder <- read.csv('data/gapminder_data.csv')

# plot GDP vs per capita
gapminder %>%
  # filter(year == 1962) %>%
  ggplot() +
  geom_point(aes(gdpPercap, lifeExp))


# how does life expectancy change overtime
gapminder %>%
  group_by(year) %>%
  summarise(lifexpt_av = mean(lifeExp),
            ) %>%
  ggplot() +
  geom_point(aes(year, lifexpt_av))


# how does life expectancy change overtime
gapminder %>%
  ggplot() +
  geom_line(aes(year, lifeExp,
                 colour = continent,
                 group = country)) +
  geom_point(aes(year, lifeExp,
                colour = continent,
                group = country), size = 0.1)
  

# Transform data
gapminder %>%
  # filter(country == 'Vietnam') %>%
  ggplot() +
  #  geom_line(aes(log(gdpPercap), log(lifeExp), col = 'sausages1')) +
  geom_point(aes(log(gdpPercap), log(lifeExp), col = 'sausages')) +
  geom_smooth(aes(log(gdpPercap), log(lifeExp)), method = 'lm') 

  




gapminder[gapminder$country == 'Vietnam',]
             