
# Libraries ---------------------------------------------------------------

library(data.table)
library(tidyverse)
library(plotly)
library(patchwork)
library(janitor)
library(quantmod)
library(rmarkdown)

# Constants ----------------------------------------------------------------

data_download <- FALSE

# inflation 
start_year <- 1957
end_year <- 2025

# Nifty 50 data
Nifty_download_from <- "2025-01-01"
Nifty_start_year <- 2000
Nifty_end_year <- 2025

# investment --------------------------------------------------------------

additional_investment <- data.table(
  year = c(2015,2015,2020, 2024),
  month_num = c(1,4,3, 1),
  amount = c(5000,6000,4000, 3000)
)

