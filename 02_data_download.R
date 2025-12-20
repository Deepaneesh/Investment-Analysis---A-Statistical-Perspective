
# Inflation data ----------------------------------------------------------

url <- paste0(
  "https://fred.stlouisfed.org/graph/fredgraph.csv?",
  "id=INDCPIALLMINMEI",
  "&cosd=",start_year,
  "&coed=",end_year
)

inflation_data <- fread(url)
inflation_data <- inflation_data %>% rename ("date" = "observation_date", "CPI" = "INDCPIALLMINMEI" )

inflation_data
fwrite(inflation_data, "input/inflation_data.csv")

rm(url, inflation_data)

