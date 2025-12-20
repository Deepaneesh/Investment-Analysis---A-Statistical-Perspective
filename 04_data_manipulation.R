
# Adding the necessary compounents to the inflation data

inflation_data <-  inflation_data %>% mutate(
  date = as.Date(date),
  month_year = format(date, "%b - %Y"),
  year = year(date),
  month = month(date, label = TRUE),month_num = month(date)
) %>% select(date,year,month_num,month,month_year,CPI)

