

# Calculating the inflation rate ------------------------------------------

inflation_data <- inflation_data %>%
  mutate(
   inflation_rate = inflation_rate(CPI, lag = 1) 
  )

yearly_inflation_data <-  inflation_data %>% filter(month_num == 1) %>%
  select(date,year, CPI) %>%
  mutate(
    yearly_inflation_rate = inflation_rate(CPI, lag = 1)
  )
