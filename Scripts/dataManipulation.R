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



gapminder %>% 
  group_by(continent) %>%
  summarise(count = n(),
    mean_GDP = mean(gdpPercap),
    minGDP = min(gdpPercap))

# summarise by year
gapminder %>% 
  group_by(year) %>%
  summarise(count = n(),
            mean_GDP = mean(gdpPercap),
            minGDP = min(gdpPercap))




meanLifeExp = gapminder %>% 
  group_by(country) %>%
  summarise(count = n(),
            meanLife = mean(lifeExp),
            maxLife = min(lifeExp),
            )


meanLifeExp %>%
  filter(meanLife == min(meanLife) | meanLife == max(meanLife))




gapminder %>% 
  group_by(country) %>%
  summarise(count = n(),
    mean_gdp = mean(gdpPercap),
            sd_gdp = stats::sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = stats::sd(pop))


gapminder %>%
  group_by(continent) %>%
  summarise(SE_lifeExp = sd(lifeExp)/sqrt(n()),
            )



gapminder %>%
  mutate(gdp_per_billion = gdpPercap*pop/10e9) %>%
  group_by(continent, year) %>%
  summarise(mean_gdp_perCap = mean(gdpPercap),
            sd_gdp_perCap = sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = sd(pop),
            mean_gdp_billion = mean(gdp_per_billion),
            sd_gdp_billion = sd(gdp_per_billion))







gapminder %>%
  mutate(gdp_per_billion = ifelse(lifeExp > 55, gdpPercap*pop/10e9, NA)) %>%
  group_by(continent, year) %>%
  summarise(mean_gdp_perCap = mean(gdpPercap),
            sd_gdp_perCap = sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = sd(pop),
            mean_gdp_billion = mean(gdp_per_billion),
            sd_gdp_billion = sd(gdp_per_billion))
 