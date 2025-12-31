
# Inflation growth --------------------------------------------------------

past_inflation_return <- investment_growth(
  inflation_data,
  initial_investment = 0,
  add_investment = additional_investment,
  growth_col = "inflation"
) 
past_inflation_return %>%
  ggplot(aes(x = date)) +
  geom_line(
    aes(y = investment_current_value, color = "Investment Current Value"),
    size = 1
  ) +
  geom_line(
    aes(y = actual_investment, color = "Actual Investment"),
    size = 1
  ) +
  labs(
    title = "Investment Growth Over Time with Inflation Rate",
    x = "Date",
    y = "Investment Value",
    color = "Investment Type"
  ) +
  scale_color_manual(
    values = c(
      "Investment Current Value" = "blue",
      "Actual Investment" = "green"
    )
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    legend.position = "bottom"
  )

#Nifty 50 Investment Growth ------------------------------------------------

past_nifty_50_return <- investment_growth(
  nifty_data,
  initial_investment = 0,
  add_investment = additional_investment,
  growth_col = "monthly_return"
) 
past_nifty_50_return %>% 
  ggplot(aes(x = date)) +
  
  geom_line(
    aes(
      y = investment_current_value,
      color = "Investment Current Value"
    ),
    size = 1
  ) +
  
  geom_line(
    aes(
      y = actual_investment,
      color = "Actual Investment"
    ),
    size = 1
  ) +
  
  labs(
    title = "Investment Growth Over Time with NIFTY 50 Returns",
    x = "Date",
    y = "Investment Value",
    color = "investment Type"
  ) +
  
  scale_color_manual(
    values = c(
      "Investment Current Value" = "green",
      "Actual Investment" = "blue"
    )
  ) +
  
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    legend.position = "bottom"
  )


# Comparing both inflation and nifty 50 -----------------------------------

comparison_data <- past_inflation_return %>%
  select(date,month,year, investment_current_value_inflation = investment_current_value) %>%
  full_join(
    past_nifty_50_return %>%
      select(month,year, investment_current_value_nifty = investment_current_value,actual_investment),
    by = c("month","year")
  ) %>% 
  full_join(
    my_growth %>% select(month,year,investment_growth) %>% 
      mutate(month = month(month, label = TRUE)),
    by = c("month","year")
  )
comparison_data[is.na(date), date := ymd(paste(year, month, 28, sep = "-"))]

past_investment_plot <- comparison_data %>% filter(year >= 2023) %>%
  ggplot(aes(x = date)) +
  
  geom_line(
    aes(
      y = investment_current_value_inflation,
      color = "Inflation growth Investment"
    ),
    size = 1
  ) +
  
  geom_line(
    aes(
      y = investment_current_value_nifty,
      color = "NIFTY 50 growth Investment"
    ),
    size = 1
  ) +
  
  geom_line(
    aes(
      y = actual_investment,
      color = "Actual Investment"
    ),
    size = 1 , linetype = "dashed"
  ) +
  geom_line(
    aes(
      y = investment_growth,
      color = "investment_growth"
    ),
    size = 1
  ) +
  
  labs(
    title = "Investment Growth Over Time: Inflation vs NIFTY 50 vs Actual",
    x = "Date",
    y = "Investment Value",
    color = "Investment Type"
  ) +
  
  scale_color_manual(
    values = c(
      "Inflation growth Investment" = "red",
      "NIFTY 50 growth Investment" = "blue",
      "Actual Investment" = "black",
      "investment_growth" = "green"
    )
  ) +
  
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    legend.position = "bottom"
  )+
  scale_x_date(
    date_breaks = "1 years",
    date_labels = "%Y"
  ) 
past_investment_plot
ggplotly(past_investment_plot)
