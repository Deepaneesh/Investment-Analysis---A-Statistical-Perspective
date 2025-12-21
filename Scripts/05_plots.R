
# CPI plot ----------------------------------------------------------------

cpi_plot <- inflation_data %>% ggplot(aes(x=date,y=CPI))+
  geom_line(color = "blue")+
  labs(title = "Consumer Price Index (CPI) over Time",
       x = "Date", y = "CPI")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5 , face = "bold"))

cpi_plot

cpi_plotly <- ggplotly(cpi_plot)

cpi_plotly

# Monthly inflation rate --------------------------------------------------

monthly_inflation_plot = inflation_data %>% ggplot(
  aes(x=month,y=as.factor(year),fill = inflation_rate)
)+geom_tile(color = "white")+
  scale_fill_gradient2(
    low = "red",
    mid = "white",
    high = "green",
    midpoint = 0 )+
  theme_minimal()+
  scale_y_discrete(limits = rev)+
  scale_x_discrete(position = "top")+
  geom_text(aes(label = paste0(round(inflation_rate,1),"%")),size = 2)+
  labs(title = "Inflation growth rate",
        x = "Month", y = "years")+
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5 , face = "bold"))
monthly_inflation_plot

ggplotly(monthly_inflation_plot)

# Yearly inflation rate ---------------------------------------------------

yearly_inflation_plot <- yearly_inflation_data %>% ggplot(
  aes(y=as.factor(year), x=inflation_rate,fill = yearly_inflation_rate)
)+geom_tile(color = "white")+
  scale_fill_gradient2(
    low = "red",
    mid = "white",
    high = "green",
    midpoint = 0 )+
  theme_minimal()+
  scale_y_discrete(limits = rev)+
  scale_x_discrete(position = "top")+
  geom_text(aes(label = paste0(round(yearly_inflation_rate,1),"%")),size = 2)+
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


