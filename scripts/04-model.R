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
library(styler)

# Style the code:
#style_file("scripts/04-model.R")

#### Read data ####
analysis_data <- read_csv("data/analysis_data/analysis_data.csv")

# Convert income to thousands for ease of analysis
analysis_data <- analysis_data %>%
  mutate(income = income / 1000)

# Set seed for reproducibility
set.seed(302)

### Model data ####

# Socio-economic models
socioeconomic_gaussian_model <-
  stan_glm(
    percent_voted ~ percent_uneducated + income + unemployment_rate,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 302
  )


socioeconomic_poisson_model <-
  stan_glm(
    number_voted ~ percent_uneducated + income + unemployment_rate,
    data = analysis_data,
    family = poisson(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 302
  )


socioeconomic_negative_binomial_model <-
  stan_glm(
    number_voted ~ percent_uneducated + income + unemployment_rate,
    data = analysis_data,
    family = neg_binomial_2(link = "log"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 302
  )


# Demographic models

demographic_gaussian_model <-
  stan_glm(
    percent_voted ~ num_sub + population,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 302
  )


demographic_poisson_model <-
  stan_glm(
    number_voted ~ num_sub + population,
    data = analysis_data,
    family = poisson(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 302
  )


demographic_negative_binomial_model <-
  stan_glm(
    number_voted ~ num_sub + population,
    data = analysis_data,
    family = neg_binomial_2(link = "log"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 302
  )

# Print prior summaries to know the adjusted priors
prior_summary(socioeconomic_gaussian_model)
prior_summary(socioeconomic_poisson_model)
prior_summary(demographic_gaussian_model)
prior_summary(demographic_poisson_model)

#### Save model ####
saveRDS(
  socioeconomic_gaussian_model,
  file = "models/socioeconomic_gaussian_model.rds"
)

saveRDS(
  socioeconomic_poisson_model,
  file = "models/socioeconomic_poisson_model.rds"
)

saveRDS(
  socioeconomic_negative_binomial_model,
  file = "models/socioeconomic_negative_binomial_model.rds"
)

saveRDS(
  demographic_gaussian_model,
  file = "models/demographic_gaussian_model.rds"
)

saveRDS(
  demographic_poisson_model,
  file = "models/demographic_poisson_model.rds"
)

saveRDS(
  demographic_negative_binomial_model,
  file = "models/demographic_negative_binomial_model.rds"
)




