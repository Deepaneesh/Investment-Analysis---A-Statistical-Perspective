
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
    add_investment = NULL,      
    growth_col = "inflation",   
    invest_col = "investment_current_value",
    actual_col = "actual_investment"
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
  
  gcol <- growth_col
  icol <- invest_col
  acol <- actual_col
  
  # actual investment (no growth)
  dt[, (acol) := initial_investment + cumsum(add_amt)]
  
  # investment current value (with growth)
  dt[, (icol) := {
    v <- numeric(.N)
    v[1] <- initial_investment
    
    for (i in 2:.N) {
      v[i] <- (v[i - 1] + add_amt[i]) *
        (1 + get(gcol)[i] / 100)
    }
    v
  }]
  
  dt[]
}

# investment_growth <- function(
#     dt,
#     initial_investment = 0,
#     add_investment = NULL,      # data.table: year, month_num, amount
#     growth_col = "inflation",   # column name for growth/inflation
#     invest_col = "investment_current_value"   # output investment column name
# ) {
#   library(data.table)
#   
#   dt <- copy(dt)
#   setorder(dt, date)
#   
#   # column to hold additional investment
#   dt[, add_amt := 0]
#   
#   # merge additional investments if provided
#   if (!is.null(add_investment)) {
#     setkey(add_investment, year, month_num)
#     setkey(dt, year, month_num)
#     
#     dt[add_investment, add_amt := i.amount]
#   }
#   
#   gcol <- growth_col
#   icol <- invest_col
#   
#   # investment calculation
#   dt[, (icol) := {
#     v <- numeric(.N)
#     v[1] <- initial_investment
#     
#     for (i in 2:.N) {
#       v[i] <- (v[i - 1] + add_amt[i]) *
#         (1 + get(gcol)[i] / 100)
#     }
#     v
#   }]
#   
#   dt[] %>% data.table()
# }
