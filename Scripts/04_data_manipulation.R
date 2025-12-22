
# Adding the necessary compounents to the inflation data

inflation_data <-  inflation_data %>% mutate(
  date = as.Date(date),
  month_year = format(date, "%b - %Y"),
  year = year(date),
  month = month(date, label = TRUE),month_num = month(date)
) %>% select(date,year,month_num,month,month_year,CPI)

# Calculating the inflation rate ------------------------------------------

inflation_data <- inflation_data %>% arrange(date) %>% 
  mutate(
    inflation = growth_rate(CPI, lag = 1) 
  )

yearly_inflation_data <-  inflation_data %>% filter(month_num == 1) %>%
  select(date,year, CPI) %>%
  mutate(
    inflation = growth_rate(CPI, lag = 1),
    inflation_rate = "Yearly"
  )

# Nifty data manipulation ------------------------------------------------
nifty_data <- nifty_data %>% mutate(
  date = as.Date(Date),
  month_year = format(Date, "%b - %Y"),
  year = year(date),
  month = month(date, label = TRUE),month_num = month(date)
) %>% select(date,year,month_num,month,month_year,Close) %>% arrange(date)

# Calculating the monthly return ------------------------------------------
nifty_data <- nifty_data %>%
  mutate(
    monthly_return = growth_rate(Close, lag = 1)
  )
# Calculating the yearly return -------------------------------------------
yearly_nifty_data <-  nifty_data %>% filter(month_num == 1) %>% 
  select(date,year, Close) %>%
  mutate(
    yearly_return = growth_rate(Close, lag = 1),
    return_type = "Yearly"
  )




