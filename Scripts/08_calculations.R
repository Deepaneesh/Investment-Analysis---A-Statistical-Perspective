cal_investment <- additional_investment %>% mutate(date = as.Date(paste(year,month_num,"01",sep = "-"))) %>% 
   as.data.table()

cal_growth <- my_growth %>% mutate(date = as.Date(paste(year,month,"01",sep = "-")))  %>% as.data.table()
# Overall XIRR calculation -------------------------------------------------
current_investment_value <- cal_growth %>% filter(date == max(date)) %>% .[, investment_growth] 
current_investment_dates <- cal_growth %>% filter(date == max(date)) %>% .[, date]

cal_investment_xirr <- XIRR(
  investments = cal_investment$amount,
  invest_dates = cal_investment$date,
  current_value = current_investment_value,
  current_date = current_investment_dates
)
total_invested_amount <- sum(cal_investment$amount)
overall_return <- ((current_investment_value - total_invested_amount)/total_invested_amount)*100
paste0("XIRR on my investment is ", round(cal_investment_xirr*100,2), "%")
paste0("Overall return on my investment is ", round(overall_return,2), "%")


# Stock XIRR ------------------------------------------------------------

stock_investment <- investment %>% mutate(date = as.Date(paste(year,month,"01",sep = "-"))) %>%
  as.data.table() %>% select(date,stock) 
stock_growth <- my_growth %>% mutate(date = as.Date(paste(year,month,"01",sep = "-")))  %>%
  as.data.table() %>% select(date, stock)
stock_investment[is.na(stock), stock := 0]
current_stock_value <- stock_growth %>% filter(date == max(date)) %>% .[, stock]
current_stock_dates <- stock_growth %>% filter(date == max(date)) %>% .[, date]
stock_investment_xirr <- XIRR(
  investments = stock_investment$stock,
  invest_dates = stock_investment$date,
  current_value = current_stock_value,
  current_date = current_stock_dates
)

total_stock_invested_amount <- sum(stock_investment$stock)
overall_stock_return <- ((current_stock_value - total_stock_invested_amount)/total_stock_invested_amount)*100
paste0("XIRR on my stock investment is ", round(stock_investment_xirr*100,2), "%")
paste0("Overall return on my stock investment is ", round(overall_stock_return,2), "%")


# Mutual fund -------------------------------------------------------------

mf_investment <- investment %>% mutate(date = as.Date(paste(year,month,"01",sep = "-"))) %>%
  as.data.table() %>% select(date,`mutual fund`)
mf_growth <- my_growth %>% mutate(date = as.Date(paste(year,month,"01",sep = "-")))  %>%
  as.data.table() %>% select(date, `mutual fund`)
mf_investment[is.na(`mutual fund`), `mutual fund` := 0]
current_mf_value <- mf_growth %>% filter(date == max(date)) %>%
  .[, `mutual fund`]
current_mf_dates <- mf_growth %>% filter(date == max(date)) %>%
  .[, date]

mf_investment_xirr <- XIRR(
  investments = mf_investment$`mutual fund`,
  invest_dates = mf_investment$date,
  current_value = current_mf_value,
  current_date = current_mf_dates)

total_mf_invested_amount <- sum(mf_investment$`mutual fund`)  
overall_mf_return <- ((current_mf_value - total_mf_invested_amount)/total_mf_invested_amount)*100
paste0("XIRR on my mutual fund investment is ", round(mf_investment_xirr*100,2), "%")
paste0("Overall return on my mutual fund investment is ", round(overall_mf_return,2), "%")


# FD ----------------------------------------------------------------------

fd_investment <- investment %>% mutate(date = as.Date(paste(year,month,"01",sep = "-"))) %>%
  as.data.table() %>% select(date,FD)
fd_growth <- my_growth %>% mutate(date = as.Date(paste(year,month,"01",sep = "-")))  %>%
  as.data.table() %>% select(date, FD)
fd_investment[is.na(FD), FD := 0]
current_fd_value <- fd_growth %>% filter(date == max(date)) %>%
  .[, FD]
current_fd_dates <- fd_growth %>% filter(date == max(date)) %>%
  .[, date]
fd_investment_xirr <- XIRR(
  investments = fd_investment$FD,
  invest_dates = fd_investment$date,
  current_value = current_fd_value,
  current_date = current_fd_dates)
total_fd_invested_amount <- sum(fd_investment$FD)
overall_fd_return <- ((current_fd_value - total_fd_invested_amount)/total_fd_invested_amount)*100
paste0("XIRR on my FD investment is ", round(fd_investment_xirr*100,2), "%")
paste0("Overall return on my FD investment is ", round(overall_fd_return,2), "%")

# Gold --------------------------------------------------------------------
gold_investment <- investment %>% mutate(date = as.Date(paste(year,month,"01",sep = "-"))) %>%
  as.data.table() %>% select(date,gold)
gold_growth <- my_growth %>% mutate(date = as.Date(paste(year,month,"01",sep = "-")))  %>%
  as.data.table() %>% select(date, gold)
gold_investment[is.na(gold), gold := 0]
current_gold_value <- gold_growth %>% filter(date == max(date)) %>%
  .[, gold]
current_gold_dates <- gold_growth %>% filter(date == max(date)) %>%
  .[, date]
gold_investment_xirr <- XIRR(
  investments = gold_investment$gold,
  invest_dates = gold_investment$date,
  current_value = current_gold_value,
  current_date = current_gold_dates)
total_gold_invested_amount <- sum(gold_investment$gold)
overall_gold_return <- ((current_gold_value - total_gold_invested_amount)/total_gold_invested_amount)*100
paste0("XIRR on my gold investment is ", round(gold_investment_xirr*100,2), "%")
paste0("Overall return on my gold investment is ", round(overall_gold_return,2), "%")
