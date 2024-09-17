require(tidyverse)

# import data

gapminder = read.csv('data/gapminder_data.csv')

# select America data
gapminder %>%
  filter(continent == 'Americas') %>%
  ggplot(aes(year, lifeExp)) +
  geom_line() +
  facet_wrap(~ country) +
  theme(axis.text.x = element_text(angle = 45))
   
gapminder %>%
  mutate(startsWith = substr(country,1,1)) %>%
  filter(startsWith %in% c('A', 'Z')) %>%
  ggplot(aes(year, lifeExp, colour = continent)) +
  geom_line() +
  facet_wrap(~ country) +
  theme(axis.text.x = element_text(angle = 45))
  # theme_minimal()



gapminder %>%
  filter(year == 2002) %>%
  group_by(continent, country) %>%
  summarise(mean_lifeExp = mean(lifeExp)) %>%
  sample_n(size = 2) 
  
  