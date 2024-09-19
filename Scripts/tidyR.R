require(tidyverse)


# import data
gapminder = read.csv('data/gapminder_data.csv')
gapminder_wider = read.csv('data/gapminder_wide.csv')

str(gapminder)

# pivot longer

gapminder_longer = gapminder_wider %>%
  pivot_longer(
    cols = c(starts_with('pop'), starts_with('lifeExp'), starts_with('gdpPercap')),
    names_to = 'obstype_year',
    values_to = 'obs_values')


gap_long = gapminder_longer %>%
  separate(obstype_year,
           into = c("obs_type", "year"),
           sep = "_") %>%
  mutate(year = as.integer(year))



# summarise and pivot longer
gap_long %>%
  group_by(continent, obs_type) %>%
  summarise(mean = mean(obs_values)) %>%
  pivot_wider(names_from = obs_type,
              values_from = mean)



# convert long to wide ----------------------------------------------------

gap_long %>%
  unite(var_ID, continent, country, sep = '_') %>%
  unite(var_name, obs_type, year, sep = "_") %>%
  pivot_wider(names_from = var_name,
              values_from = obs_values)
