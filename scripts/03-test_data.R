#### Preamble ####
# Purpose: Tests and validates the cleaned data for reasonability and correctness
# Author: Janel Gilani
# Date: 17 April 2024
# Contact: janel.gilani@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R, 02-data_cleaning.R


#### Workspace setup ####
library(tidyverse)

#### Test data ####
analysis_data <- read_csv("data/analysis_data/analysis_data.csv")

# All the below tests should return TRUE

class(analysis_data$ward_id) == "numeric" # Check if ward_id is an integer
class(analysis_data$ward_name) == "character" # Check if ward_name is a character
class(analysis_data$percent_uneducated) == "numeric" # Check if percent_uneducated is a double
class(analysis_data$unemployment_rate) == "numeric" # Check if unemployment_rate is a double
class(analysis_data$income) == "numeric" # Check if income is a double
class(analysis_data$percent_voted) == "numeric" # Check if percent_voted is a double

length(unique(analysis_data$ward_id)) == 25 # Check if ward_id is unique
length(unique(analysis_data$ward_id)) == nrow(analysis_data) # Check if ward_id is unique

min(analysis_data$percent_uneducated) >= 0 # Check if percent_uneducated is non-negative
max(analysis_data$percent_uneducated) <= 100 # Check if percent_uneducated is less than or equal to 100

min(analysis_data$unemployment_rate) >= 0 # Check if unemployment_rate is non-negative
max(analysis_data$unemployment_rate) <= 100 # Check if unemployment_rate is less than or equal to 100

min(analysis_data$income) >= 0 # Check if income is non-negative
max(analysis_data$income) <= 1000000 # Check if income is less than or equal to 100000

min(analysis_data$percent_voted) >= 0 # Check if percent_voted is non-negative
max(analysis_data$percent_voted) <= 100 # Check if percent_voted is less than or equal to 100

any(is.na(analysis_data)) == FALSE # Check if there are no missing values in the dataset