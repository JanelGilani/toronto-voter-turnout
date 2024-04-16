#### Preamble ####
# Purpose: Simulates the ward and elections data across Toronto
# Author: Janel Gilani
# Date: 17 April 2024
# Contact: janel.gilani@mail.utoronto.ca
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(302)
number_of_obs = 25

sim_ward_id = c(1:25)
sim_population = c(1:100000)
sim_income = c(1:100000)
sim_turnout_num = c(1:100000)
sim_turnout_perc = c(1:100)
sim_num_subdivisions = c(1:100)
sim_uneducated_perc = c(1:30) # percent of uneducated population is typically between 10-30%
sim_unemployed_perc = c(1:30) # unemployment rate is typically less than 30%

sim_data = tibble(
  ward_id = sample(sim_ward_id, number_of_obs, replace = FALSE),
  population = sample(sim_population, number_of_obs, replace = TRUE),
  income = sample(sim_income, number_of_obs, replace = TRUE),
  number_voted = sample(sim_turnout_num, number_of_obs, replace = TRUE),
  percent_voted = sample(sim_turnout_perc, number_of_obs, replace = TRUE),
  num_sub = sample(sim_num_subdivisions, number_of_obs, replace = TRUE),
  percent_uneducated = sample(sim_uneducated_perc, number_of_obs, replace = TRUE),
  unemployment_rate = sample(sim_unemployed_perc, number_of_obs, replace = TRUE)
)

sim_data$ward_id = as.numeric(sim_data$ward_id)
sim_data$population = as.numeric(sim_data$population)
sim_data$income = as.numeric(sim_data$income)
sim_data$number_voted = as.numeric(sim_data$number_voted)
sim_data$percent_voted = as.numeric(sim_data$percent_voted)
sim_data$num_sub = as.numeric(sim_data$num_sub)
sim_data$percent_uneducated = as.numeric(sim_data$percent_uneducated)
sim_data$unemployment_rate = as.numeric(sim_data$unemployment_rate)


# Data Validation:

class(sim_data$ward_id) == "numeric" # Check if ward_id is an integer
class(sim_data$percent_uneducated) == "numeric" # Check if percent_uneducated is a double
class(sim_data$unemployment_rate) == "numeric" # Check if unemployment_rate is a double
class(sim_data$income) == "numeric" # Check if income is a double
class(sim_data$percent_voted) == "numeric" # Check if percent_voted is a double
class(sim_data$population) == "numeric" # Check if population is a double
class(sim_data$num_sub) == "numeric" # Check if number of subdivisions is a double
class(sim_data$number_voted) == "numeric" # Check if ward_id is a double

length(unique(sim_data$ward_id)) == 25 # Check if ward_id is unique
length(unique(sim_data$ward_id)) == nrow(sim_data) # Check if ward_id is unique

min(sim_data$percent_uneducated) >= 0 # Check if percent_uneducated is non-negative
max(sim_data$percent_uneducated) <= 100 # Check if percent_uneducated is less than or equal to 100

min(sim_data$unemployment_rate) >= 0 # Check if unemployment_rate is non-negative
max(sim_data$unemployment_rate) <= 100 # Check if unemployment_rate is less than or equal to 100

min(sim_data$income) >= 0 # Check if income is non-negative
max(sim_data$income) <= 1000000 # Check if income is less than or equal to 100000

min(sim_data$population) >= 0 # Check if population is non-negative
max(sim_data$population) <= 1000000 # Check if population is less than or equal to 100000

min(sim_data$num_sub) >= 0 # Check if number of subdivisions is non-negative
max(sim_data$num_sub) <= 100 # Check if number of subdivisions is less than or equal to 100

min(sim_data$percent_voted) >= 0 # Check if percent_voted is non-negative
max(sim_data$percent_voted) <= 100 # Check if percent_voted is less than or equal to 100

min(sim_data$number_voted) >= 0 # Check if number_voted is non-negative
max(sim_data$number_voted) <= 1000000 # Check if number_voted is less than or equal to 100000

any(is.na(sim_data)) == FALSE # Check if there are no missing values in the dataset


# Plotting the data:

ggplot(sim_data, aes(x = ward_id, y = population)) +
  geom_point() +
  labs(title = "Population by Ward",
       x = "Ward ID",
       y = "Population")

ggplot(sim_data, aes(x = ward_id, y = income)) +
  geom_point() +
  labs(title = "Income by Ward",
       x = "Ward ID",
       y = "Income")

ggplot(sim_data, aes(x = ward_id, y = number_voted)) +
  geom_point() +
  labs(title = "Number of People Voted by Ward",
       x = "Ward ID",
       y = "Number of People Voted")

ggplot(sim_data, aes(x = ward_id, y = percent_voted)) +
  geom_point() +
  labs(title = "Percentage of People Voted by Ward",
       x = "Ward ID",
       y = "Percentage of People Voted")

ggplot(sim_data, aes(x = ward_id, y = num_sub)) +
  geom_point() +
  labs(title = "Number of Subdivisions by Ward",
       x = "Ward ID",
       y = "Number of Subdivisions")

ggplot(sim_data, aes(x = ward_id, y = percent_uneducated)) +
  geom_point() +
  labs(title = "Percentage of Uneducated People by Ward",
       x = "Ward ID",
       y = "Percentage of Uneducated People")

ggplot(sim_data, aes(x = ward_id, y = unemployment_rate)) +
  geom_point() +
  labs(title = "Unemployment Rate by Ward",
       x = "Ward ID",
       y = "Unemployment Rate")



