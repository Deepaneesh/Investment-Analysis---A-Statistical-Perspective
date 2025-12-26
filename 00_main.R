# press f2 on each script to explore the code


# Cleaning the working directory ------------------------------------------

rm(list = ls());gc()

# Load constant ----------------------------------------------------------

source("Scripts/01_set_constant.R")

# Loading Functions -------------------------------------------------------

source("Scripts/00_functions.R")

# Data Download -----------------------------------------------------------

if(data_download){
  source("Scripts/02_data_download.R")
}

# Input -------------------------------------------------------------------

source("Scripts/03_input.R")

# Data manipulation  --------------------------------------------------------

source("Scripts/04_data_manipulation.R")

# Plot --------------------------------------------------------------------

source("Scripts/05_plots.R")

# Investment Simulation ---------------------------------------------------

source("Scripts/06_investment_simulation.R")


# Investment Comparsion ---------------------------------------------------

source("Scripts/07_investment_comparison.R")

# Report Generation -------------------------------------------------------

source("Scripts/report_generation.R")
