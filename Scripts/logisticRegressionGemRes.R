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
         region = as.factor(region),
         ethnicity = as.factor(ethnicity),
         had_surgery_past_yr = as.factor(had_surgery_past_yr)
  )



# split data
train <- amrData %>% dplyr::sample_frac(0.01)



sDxy = with(train,
            rcorrcens(factor(coamox) ~ age_years_sd + as.factor(sex_male) +
                        as.factor(had_surgery_past_yr) +
                         as.factor(region) + as.factor(imd)))

plot(sDxy)



redundancy = with(train,
     redun(~ factor(coamox) + age_years_sd + as.factor(sex_male) +
             as.factor(had_surgery_past_yr) +
             as.factor(region) + as.factor(imd),
           r2 = 0.6, type = 'adjusted'))

redundancy$Out


dd = datadist(amrData)
options(datadist = dd)

f = lrm(gentam ~ age_years_sd + sex_male + had_surgery_past_yr + 
          coamox +  cipro +  age_years_sd,
        data = amrData,
        x = TRUE, y= TRUE)


# plot predicted variables
ggplot(Predict(f))

v = validate(f, b= 1000)

# Calcualte concordance index
Dxy = v[1,5]
c.index = Dxy*0.5+0.5

sprintf('The model is able to correctly descriminate %s%% of the samples correctly', round(c.index*100, digits = 2))


cal = calibrate(f, B=1000)
plot(cal)

