
# Libraries ---------------------------------------------------------------

library(data.table)
library(tidyverse)
library(plotly)
library(patchwork)
library(janitor)
library(quantmod)
library(rmarkdown)
library(readxl)

# Constants ----------------------------------------------------------------

data_download <- FALSE

# inflation 
start_year <- 1957
end_year <- 2025

# Nifty 50 data
Nifty_download_from <- "2025-01-01"
Nifty_start_year <- 2000
Nifty_end_year <- 2025


