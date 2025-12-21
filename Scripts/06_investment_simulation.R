investment_growth(
  inflation_data %>% rename("inflation" = "inflation_rate"),
  initial_investment = 0,
  add_investment = additional_investment
)%>% 
  ggplot(aes(x = date, y = investment)) +
  geom_line(color = "blue", size = 1) +
  geom_bar(
    data = additional_investment %>%
      mutate(
        date = as.Date(paste0(year, "-", month_num, "-01"))
      ),
    aes(x = date, y = amount),
    stat = "identity",
    fill = "orange",
    alpha = 0.5
  ) +
  labs(
    title = " Investment Growth Over Time with inflation rate ",
    x = "Date",
    y = "Investment Value"
  ) +
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5 , face = "bold"))

