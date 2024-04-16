#### Preamble ####
# Purpose: Cleans and merges the ward and elections raw data
# Author: Janel Gilani
# Date: 17 April 2024
# Contact: janel.gilani@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R

#### Workspace setup ####


library(tidyverse)
library(janitor)
library(arrow)
library(styler)

# Style the code:
#style_file("scripts/02-data_cleaning.R")

#### Clean data ####
# Below code referred from: https://github.com/christina-wei/INF3104-1-Covid-Clinics/blob/main/scripts/01-data_cleaning.R

# Election data:
raw_data_1 <- read_csv("data/raw_data/raw_election_data.csv")

# Extract the number of sub-divisions in each ward:
cleaned_election_data <- clean_names(raw_data_1)
sub_data = 
  cleaned_election_data |>
  select(ward, sub) |>
  group_by(ward) |>
  count(
    total = max(sub, na.rm = TRUE) 
  ) |>
  select(ward, n) |>
  filter(n > 1) 
sub_data = sub_data |>
  rename(
    num_sub = n,
  ) |>
  mutate(ward = as.numeric(ward))

sub_data = sub_data |>
  arrange(ward)

#print(n =25, sub_data)

# Extract the percentage of people who voted in each ward and the number of voters:
cleaned_election_data <- cleaned_election_data %>%
  filter(grepl("Total", ward, ignore.case = TRUE) & !grepl("Grand Total", ward, ignore.case = TRUE))

cleaned_election_data <- cleaned_election_data %>%
  mutate(ward = as.numeric(gsub(" Total", "", ward))) %>%
  select(ward, percent_voted, number_voted)

cleaned_election_data$percent_voted <- cleaned_election_data$percent_voted * 100

cleaned_election_data <- cleaned_election_data %>%
  left_join(sub_data, by = c("ward" = "ward"))

#head(cleaned_election_data)

# Ward data:
raw_data_2 <- read_csv("data/raw_data/raw_ward_data.csv")

# Only keep the relevant columns:
cleaned_ward_data <-
  raw_data_2[c(18, 997, 1307, 1383), ] 
cleaned_ward_data <- as.data.frame(t(cleaned_ward_data)) |>
  slice(-1) |>
  slice(-1) |>
  rename(population = V1, num_uneducated = V2, 
         unemployment_rate = V3, income = V4)

# Add ward_id column:
cleaned_ward_data$ward_id = 1:25
cleaned_ward_data = cleaned_ward_data[c("ward_id", setdiff(names(cleaned_ward_data),
                                                        "ward_id"))]

# Convert columns to numeric:
cleaned_ward_data <- cleaned_ward_data %>%
  mutate(across(everything(), as.numeric))

# Calculate the percentage of uneducated people in each ward:
cleaned_ward_data$percent_uneducated <- (cleaned_ward_data$num_uneducated / cleaned_ward_data$population) * 100

cleaned_ward_data <- cleaned_ward_data[c("ward_id", "population", "percent_uneducated", "unemployment_rate", "income")]

#head(cleaned_ward_data)

# Analysis data:
ward_names <- c("Etobicoke North", "Etobicoke Centre", "Etobicoke-Lakeshore", 
                "Parkdale-High Park","York South-Weston", "York Centre", 
                "Humber River-Black Creek", "Eglinton-Lawrence",
                "Davenport", "Spadina-Fort York", "University-Rosedale",
                "Toronto-St. Paul's", "Toronto Centre", "Toronto-Danforth",
                "Don Valley West", "Don Valley East", "Don Valley North",
                "Willowdale", "Beaches-East York", "Scarborough Southwest",
                "Scarborough Centre", "Scarborough-Agincourt",
                "Scarborough North", "Scarborough-Guildwood",
                "Scarborough-Rouge Park")


# Merge the cleaned election and ward data:
analysis_data <- cleaned_ward_data %>%
  left_join(cleaned_election_data, by = c("ward_id" = "ward")) %>%
  mutate(ward_name = ward_names)

analysis_data <- analysis_data %>%
  select(ward_id, ward_name, num_sub, everything())

head(analysis_data)


#### Save data ####
write_csv(analysis_data, "data/analysis_data/analysis_data.csv")
write_parquet(analysis_data, "data/analysis_data/analysis_data.parquet")
write_csv(cleaned_election_data, "data/analysis_data/cleaned_election_data.csv")
write_csv(cleaned_ward_data, "data/analysis_data/cleaned_ward_data.csv")

