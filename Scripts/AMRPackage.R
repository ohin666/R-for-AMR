require(AMR)
require(tidyverse)

our_data <- example_isolates_unclean

our_data = our_data %>%
  mutate(bacteria = as.mo(bacteria, info = TRUE))

our_data <- our_data %>%
  mutate_at(vars(AMX:GEN), as.sir)

our_data <- our_data %>%
  mutate_if(is_sir_eligible, as.sir)

firstIsolate = our_data %>%
  filter_first_isolate(info = TRUE)


firstIsolate %>%
  select(date, aminoglycosides())


firstIsolate %>%
  filter(any(betalactams() == 'R')) %>%
  select(date, bacteria, betalactams())


antibiogram(firstIsolate,
            antibiotics = c(aminoglycosides(), betalactams()))


wisca = antibiogram(example_isolates,
            antibiotics = c("AMC", "AMC+CIP", "TZP", "TZP+TOB"),
            mo_transform = "gramstain",
            minimum = 10, # this should be >= 30, but now just as example
            syndromic_group = ifelse(example_isolates$age >= 65 &
                                       example_isolates$gender == "M",
                                     "WISCA Group 1", "WISCA Group 2"))

autoplot(wisca)








# resistance prediction of piperacillin/tazobactam (TZP):
resistance_predict(tbl = example_isolates, col_date = "date", col_ab = "TZP", model = "binomial")

# or:
example_isolates %>%
  resistance_predict(
    col_ab = "TZP",
    model = "binomial"
  )

# to bind it to object 'predict_TZP' for example:
predict_TZP <- example_isolates %>%
  resistance_predict(
    col_ab = "TZP",
    model = "binomial"
  )


plot(predict_TZP)
