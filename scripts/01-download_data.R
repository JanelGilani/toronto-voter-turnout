#### Preamble ####
# Purpose: Downloads and saves the ward and elections raw data from Open Data Toronto
# Author: Janel Gilani
# Date: 17 April 2024
# Contact: janel.gilani@mail.utoronto.ca
# License: MIT
# Pre-requisites: None


#### Workspace setup ####

library(opendatatoronto)
library(tidyverse)
library(readxl)
library(styler)

# Style the code:
#style_file("scripts/01-download_data.R")


#### Download data ####

# Download the ward data:
url <- "https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/6678e1a6-d25f-4dff-b2b7-aa8f042bc2eb/resource/16a31e1d-b4d9-4cf0-b5b3-2e3937cb4121/download/2023-WardProfiles-2011-2021-CensusData.xlsx"
local_file <- tempfile(fileext = ".xlsx")
download.file(url, local_file, mode = "wb")
raw_ward_data <- read_excel(local_file)

# Download the elections data:

# Below code referenced from: https://cran.r-project.org/web/packages/opendatatoronto/opendatatoronto.pdf

raw_voter_data = list_package_resources("7dc606ab-f042-4d90-99e2-9247cb5953d2") |>
  filter(grepl("2022", name)) |>
  head(1) |>
  get_resource()

head(raw_voter_data)


#### Save data ####

# Below code referenced from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html

write_csv(raw_voter_data[["2022 Voter Turnout Statistics"]], "data/raw_data/raw_election_data.csv")
write_excel_csv(raw_ward_data,"data/raw_data/raw_ward_data.csv" )


         
