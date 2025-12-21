
# Inflation rate calculate ------------------------------------------------

growth_rate <- function(x, lag = 12) {
  c(
    rep(0, lag),
    (x[(lag + 1):length(x)] - x[1:(length(x) - lag)]) /
      x[1:(length(x) - lag)] * 100
  )
}


# investment growth calculate ---------------------------------------------

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
