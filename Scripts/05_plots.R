
# CPI plot ----------------------------------------------------------------

cpi_plot <- inflation_data  %>% ggplot(aes(x=date,y=CPI))+
  geom_line(color = "blue")+
  labs(title = "Consumer Price Index (CPI) over Time",
       x = "year", y = "CPI")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5 , face = "bold"))+
  scale_x_date(date_labels = "%Y", date_breaks = "5 year")

cpi_plot

cpi_plotly <- ggplotly(cpi_plot)

cpi_plotly

# Monthly inflation rate --------------------------------------------------

monthly_inflation_plot = inflation_data %>% ggplot(
  aes(x=month,y=as.factor(year),fill = inflation)
)+geom_tile(color = "white")+
  scale_fill_gradient2(
    low = "red",
    mid = "white",
    high = "green",
    midpoint = 0 )+
  theme_minimal()+
  scale_y_discrete(limits = rev)+
  scale_x_discrete(position = "top")+
  geom_text(aes(label = paste0(round(inflation,1),"%")),size = 2)+
  labs(title = "Inflation growth rate",
        x = "Month", y = "years")+
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5 , face = "bold"))
monthly_inflation_plot

ggplotly(monthly_inflation_plot)

# Yearly inflation rate ---------------------------------------------------

yearly_inflation_plot <- yearly_inflation_data %>% ggplot(
  aes(y=as.factor(year), x=inflation_rate,fill = inflation)
)+geom_tile(color = "white")+
  scale_fill_gradient2(
    low = "red",
    mid = "white",
    high = "green",
    midpoint = 0 )+
  theme_minimal()+
  scale_y_discrete(limits = rev)+
  scale_x_discrete(position = "top")+
  geom_text(aes(label = paste0(round(inflation,1),"%")),size = 2)+
  labs(title = "Inflation growth rate",
       x = "yearly growth value", y = "years")+
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5 , face = "bold"))

yearly_inflation_plot
ggplotly(yearly_inflation_plot)
# Combine plot ------------------------------------------------------------

inflation_plot<- monthly_inflation_plot+yearly_inflation_plot +plot_layout(ncol = 2)
inflation_plot

# combine the two plots side by side plotly style
inflation_plotly <- subplot(
  ggplotly(monthly_inflation_plot),
  ggplotly(yearly_inflation_plot),
  nrows = 1,
  shareX = FALSE,
  shareY = FALSE,
  titleX = TRUE,
  titleY = TRUE
)
inflation_plotly



# Nifty plots -------------------------------------------------------------

nifty50_plot <- nifty_data %>% ggplot(aes(x=date,y=Close))+
  geom_line(color = "blue")+
  labs(title = "Nifty 50 Closing Prices over Time",
       x = "Date", y = "Closing Price")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5 , face = "bold"))

nifty50_plot
nifty50_plotly <- ggplotly(nifty50_plot)
nifty50_plotly

# Monthly Nifty return --------------------------------------------------

monthly_nifty_plot = nifty_data %>%filter(year>1990) %>%  ggplot(
  aes(x=month,y=as.factor(year),fill = monthly_return)
)+geom_tile(color = "white")+
  scale_fill_gradient2(
    low = "red",
    mid = "white",
    high = "green",
    midpoint = 0 )+
  theme_minimal()+
  scale_y_discrete(limits = rev)+
  scale_x_discrete(position = "top")+
  geom_text(aes(label = paste0(round(monthly_return,1),"%")),size = 2,fontface="bold")+
  labs(title = "Nifty 50 Monthly Return",
       x = "Month", y = "years")+
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5 , face = "bold"))
monthly_nifty_plot
ggplotly(monthly_nifty_plot)

# Yearly Nifty return ---------------------------------------------------
yearly_nifty_plot <- yearly_nifty_data %>% ggplot(
  aes(y=as.factor(year), x=return_type,fill = yearly_return)
)+geom_tile(color = "white")+
  scale_fill_gradient2(
    low = "red",
    mid = "white",
    high = "green",
    midpoint = 0 )+
  theme_minimal()+
  scale_y_discrete(limits = rev)+
  scale_x_discrete(position = "top")+
  geom_text(aes(label = paste0(round(yearly_return,1),"%")),size = 2,fontface="bold")+
  labs(title = "Nifty 50 Yearly Return",
       x = "yearly growth value", y = "years")+
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5 , face = "bold"))
yearly_nifty_plot

ggplotly(yearly_nifty_plot)

# Combine plot ------------------------------------------------------------
nifty50_combine_plot<- monthly_nifty_plot+yearly_nifty_plot +plot_layout(ncol = 2)
nifty50_combine_plot

# combine the two plots side by side plotly style
nifty50_combine_plotly <- subplot(
  ggplotly(monthly_nifty_plot),
  ggplotly(yearly_nifty_plot),
  nrows = 1,
  shareX = FALSE,
  shareY = FALSE,
  titleX = TRUE,
  titleY = TRUE
)
nifty50_combine_plotly
