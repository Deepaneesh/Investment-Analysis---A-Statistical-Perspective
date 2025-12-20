library(data.table)
library(tidyverse)
start_year <- 1957
end_year <- 2025

inflation_rate <- function(cpi, lag = 12) {
  c(
    rep(0, lag),
    (cpi[(lag + 1):length(cpi)] - cpi[1:(length(cpi) - lag)]) /
      cpi[1:(length(cpi) - lag)] * 100
  )
}


url <- paste0(
  "https://fred.stlouisfed.org/graph/fredgraph.csv?",
  "id=INDCPIALLMINMEI",
  "&cosd=",start_year,
  "&coed=",end_year
)

dt <- fread(url)
dt <- dt %>% rename ("date" = "observation_date", "CPI" = "INDCPIALLMINMEI" )

dt <-  dt %>% mutate(
  date = as.Date(date),
  month_year = format(date, "%b - %Y"),
  year = year(date),
  month = month(date, label = TRUE),month_num = month(date)
) %>% select(date,year,month_num,month,month_year,CPI)

dt
dt$inflation<- inflation_rate(dt$CPI, lag = 1)



dt[,"investment" := 0]

investment_growth <- function(
    dt,
    initial_investment = 0,
    add_investment = NULL  # data.table: year, month_num, amount
) {
  library(data.table)
  
  dt <- copy(dt)
  setorder(dt, date)
  
  # column to hold additional investment
  dt[, add_amt := 0]
  
  # merge additional investments if provided
  if (!is.null(add_investment)) {
    setkey(add_investment, year, month_num)
    setkey(dt, year, month_num)
    
    dt[add_investment, add_amt := i.amount]
  }
  
  # investment calculation
  dt[, investment := {
    v <- numeric(.N)
    v[1] <- initial_investment
    
    for (i in 2:.N) {
      v[i] <- (v[i - 1] + add_amt[i]) *
        (1 + inflation[i] / 100)
    }
    v
  }]
  
  dt[]
}
add_dt <- data.table(
  year = c(2024, 2025),
  month_num = c(1, 1),
  amount = c(5000, 3000)
)
result_dt <- investment_growth(
  dt,
  initial_investment = 1,
  add_investment = NULL
)
result_dt
