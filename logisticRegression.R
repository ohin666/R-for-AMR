# load libaries
require(tidyverse)
require(broom)
require(rms)
require(lmtest)


# import data

amrData = read.csv('data/dig_health_hub_amr.csv') %>%
  mutate(age_years_sd = (dob %--% spec_date) %/% years(1),
         spec_date_YMD = as.Date(spec_date),
         sex_male = as.factor(sex_male),
         had_surgery_past_yr = as.factor(had_surgery_past_yr),
         coamox = as.factor(coamox),
         cipro = as.factor(cipro),
         gentam = as.factor(gentam),
         imd = as.factor(imd),
         region = as.factor(region)
  )


amrData %>%
  ggplot() +
  geom_histogram(aes(age_years_sd), bins = 10, color = 'white') +
  theme_minimal(base_size = 14, base_family = 'sans') +
  labs(x = 'Age when specimen was taken (years)', y = 'Frequency')
  


xtabs(~region, data = amrData)


Xtable = as.tibble(xtabs(~ coamox + cipro + gentam, data = amrData))

# Create logistic regression model


sDxy = with(amrData,
            rcorrcens(factor(coamox) ~ age_years_sd))

dd = datadist(amrData)
options(datadist = dd)

f = lrm(coamox ~ age_years_sd + sex_male, data = amrData, x = TRUE, y = FALSE)

f2 = lrm(coamox ~ age_years_sd + sex_male + had_surgery_past_yr,
         data = amrData, x = TRUE, y = FALSE)


#* test multicolinearity by using VIF function. This checks that two variables 
#* not providing the same information.
#* 
#* If vif function shows multicolinearity you can use redundancy test and set 
#* parameters

summary(car::vif(f2))


ggplot(Predict(f2))

plot(summary(f2), log = TRUE)




# Reporting all regions ---------------------------------------------------

coamox_region_model = lrm(coamox ~ 0 + age_years_sd + sex_male + region,
                            data = amrData, x= TRUE, y=TRUE)

summary(coamox_region_model)




summary(glm(coamox ~ 0 + age_years_sd + sex_male + region,
    data = amrData, family = 'binomial'))



f3 = lrm(coamox ~ 0 + rcs(age_years_sd,3) + sex_male + had_surgery_past_yr + imd + ethnicity,
         data = amrData, x = TRUE, y = FALSE)


anova(f3)

plot(summary(f), log = TRUE)


x = summary(f3)



# CI region

ggplot(Predict(f3))





