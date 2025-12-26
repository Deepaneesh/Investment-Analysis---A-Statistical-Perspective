
# inflation Data ----------------------------------------------------------


inflation_data <- fread("input/inflation_data.csv")

# Nifty 50 data -----------------------------------------------------------


nifty_data <- fread("input/nifty50_monthly_close.csv")



# Investment Data ---------------------------------------------------------

investment <- read_excel("input/investment & growth.xlsx", 
                                       sheet = "investment") %>% as.data.table()

additional_investment <- investment %>% select(month,year,invested) %>% 
  rename(month_num = month, amount = invested)

# My growth Data ----------------------------------------------------------
my_growth <- read_excel("input/investment & growth.xlsx", 
                                       sheet = "growth") %>% as.data.table()


# Lend data ---------------------------------------------------------------


