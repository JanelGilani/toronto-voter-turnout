# Analysis of Voter Turnout in 2022 Toronto Municipal Election

## Overview of Paper

The paper uses data from the City of Toronto's Open Data Portal to analyze the voter turnout in the 2022 Toronto Municipal Election. Specifically, the paper aims to study the relationship between a ward's voter turnout and various demographic factors such as  its number of subdivisions and population, and socio-economic factors such as its income, education level and unemployment rate.


## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from Open Data Toronto.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains datasheet and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage
No LLMs were used in the course of producing this paper.

## How to Run
1.  Run `scripts/01-download_data.R` to download raw data
2.  Run `scripts/02-data_cleaning.R` to generate cleaned data
3.  Run `scripts/03-test_data.R` to validate the cleaned data
4.  Run `scripts/04-model.R` to fit models
5.  Run `outputs/paper/toronto-voter-turnout.qmd` to generate the PDF of the paper