#### Preamble ####
# Purpose: Models the relationship between voter turnout, education level, income, and unemployment rate
# Author: Janel Gilani
# Date: 17 April 2024
# Contact: janel.gilani@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R, 02-data_cleaning.R, 03-test_data.R


#### Workspace setup ####
library(tidyverse)
library(rstanarm)


#### Read data ####
analysis_data <- read_csv("data/analysis_data/analysis_data.csv")

analysis_data <- analysis_data %>%
  mutate(income = income / 1000)

set.seed(302)

### Model data ####
gaussian_model <-
  stan_glm(
    percent_voted ~ percent_uneducated + income + unemployment_rate,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 302
  )
prior_summary(gaussian_model)

# Round percent_voted to the nearest integer for Poisson and Negative Binomial models
analysis_data$percent_voted <- round(analysis_data$percent_voted)
analysis_data$percent_voted <- as.integer(analysis_data$percent_voted)

poisson_model <-
  stan_glm(
    percent_voted ~ percent_uneducated + income + unemployment_rate,
    data = analysis_data,
    family = poisson(link = "log"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 302
  )
prior_summary(poisson_model)


negative_binomial_model <-
  stan_glm(
    percent_voted ~ percent_uneducated + income + unemployment_rate,
    data = analysis_data,
    family = neg_binomial_2(link = "log"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 302
  )
prior_summary(negative_binomial_model)


#### Save model ####
saveRDS(
  gaussian_model,
  file = "models/gaussian_model.rds"
)

saveRDS(
  poisson_model,
  file = "models/poisson_model.rds"
)

saveRDS(
  negative_binomial_model,
  file = "models/negative_binomial_model.rds"
)



