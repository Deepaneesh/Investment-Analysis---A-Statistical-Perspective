
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


# Nifty 50 ----------------------------------------------------------------

getSymbols(
  "^NSEI",
  src = "yahoo",
  from = Nifty_download_from,
  to   = Sys.Date()
)
nifty_df <- data.frame(
  date = index(NSEI),
  coredata(NSEI)
)


nifty <- nifty_df %>% mutate(
  month = month(date),
  year = year(date)
) %>% select(date, month, year, NSEI.Close) %>% 
  rename(Close = NSEI.Close,Date = date) %>% 
  group_by(year, month) %>% filter(Date == max(Date)) %>% arrange(Date) %>% ungroup()

rm(nifty_df, NSEI)
data <- read.csv("input/nifty50_monthly_close.csv")

write.csv(data, "input/nifty50_monthly_close.csv", row.names = FALSE)

compare_df_cols(nifty, data) # check if columns are same

combine_data <- rbind(nifty,data) # combine old and new data

rm(nifty, data) # remove unnecessary dataframes

combine_data %>% arrange(Date) %>% get_dupes() # check for duplicates

combine_data <- combine_data %>% distinct()  # remove duplicates

write.csv(combine_data, "input/nifty50_monthly_close.csv", row.names = FALSE)
rm(combine_data)
