# press f2 on each script to explore the code


# Cleaning the working directory ------------------------------------------

rm(list = ls());gc()

# Load constant ----------------------------------------------------------

source("01_set_constant.R")

# Loading Functions -------------------------------------------------------

source("00_functions.R")

# Data Download -----------------------------------------------------------

if(data_download){
  source("02_data_download.R")
}

# Input -------------------------------------------------------------------

source("03_input.R")

# Data manipulation  --------------------------------------------------------

source("04_data_manipulation.R")

# Descriptive Analysis ----------------------------------------------------

source("05_descriptive_analysis.R")

# Investment Simulation ---------------------------------------------------

source("06_investment_simulation.R")


