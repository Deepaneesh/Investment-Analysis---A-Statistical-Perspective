
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


# XIRR --------------------------------------------------------------------

XIRR <- function(investments,
                 invest_dates,
                 current_value,
                 current_date = Sys.Date()) {
  
  # Convert dates
  invest_dates <- as.Date(invest_dates)
  current_date <- as.Date(current_date)
  
  # Validation
  if (length(investments) != length(invest_dates)) {
    stop("investments and invest_dates must have the same length")
  }
  
  if (current_value <= 0) {
    stop("current_value must be positive")
  }
  
  # Build cash flows (Excel convention)
  cash_flows <- c(-investments, current_value)
  dates <- c(invest_dates, current_date)
  
  if (!any(cash_flows < 0) || !any(cash_flows > 0)) {
    stop("Cash flows must contain both investments and final value")
  }
  
  # Sort by date (important!)
  ord <- order(dates)
  cash_flows <- cash_flows[ord]
  dates <- dates[ord]
  
  # Time in years (Excel-style)
  t <- as.numeric(difftime(dates, dates[1], units = "days")) / 365.25
  
  # XIRR equation
  f <- function(rate) {
    sum(cash_flows / (1 + rate)^t)
  }
  
  # Solve for IRR
  uniroot(
    f,
    lower = -0.99,
    upper = 10,
    extendInt = "yes"
  )$root
}


