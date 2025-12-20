
# Libraries ---------------------------------------------------------------

library(data.table)
library(tidyverse)

# Constants ----------------------------------------------------------------
data_download <- TRUE
start_year <- 1957
end_year <- 2025

# investment --------------------------------------------------------------

additional_investment <- data.table(
  year = c(2024, 2025),
  month_num = c(1, 1),
  amount = c(5000, 3000)
)

