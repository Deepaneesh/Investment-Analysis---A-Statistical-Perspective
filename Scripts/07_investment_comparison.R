  investment_comparison <- investment %>% select(-month,-year,-`cummulative investment`) %>% 
   summarise(stock = sum(stock, na.rm = TRUE),
             mutual_fund = sum(`mutual fund`, na.rm = TRUE),
             investment_fd = sum(investment_fd, na.rm = TRUE),
             emergency_fd = sum(emergency_fd, na.rm = TRUE),
             opportunity_fd = sum(opportunity_fd, na.rm = TRUE),
             FD = sum(FD, na.rm = TRUE),
             bonds = sum(bonds, na.rm = TRUE),
             gold = sum(gold, na.rm = TRUE),
             Total = sum(invested, na.rm = TRUE)
             ) %>% pivot_longer(
               cols = everything(),
               names_to = "Asset_Class",
               values_to = "invested_Amount") %>% 
   full_join(

 my_growth %>% mutate(
   date = ymd(paste(year, month, 28, sep = "-"))) %>% 
   filter(date == max(date)) %>% select(-month,-year,-date) %>% 
   rename(Total = investment_growth,
          mutual_fund = `mutual fund`) %>% as.data.frame() %>% pivot_longer(
     cols = everything(),
     names_to = "Asset_Class",
     values_to = "Current_Value_Amount"
   ) ,
   by = "Asset_Class") %>% 
   mutate(
     growth_rate = (Current_Value_Amount - invested_Amount)/invested_Amount * 100
   ) %>% as.data.table()
  investment_comparison_data <- investment_comparison %>% .[!Asset_Class %in% c( "Total","investment_fd","emergency_fd","opportunity_fd"),invested_percent := round((invested_Amount / sum(invested_Amount)) * 100 ,2)] %>% 
    .[!Asset_Class %in% c( "investment_fd","emergency_fd","opportunity_fd")] %>% 
    .[Asset_Class == "Total" , invested_percent := 1] %>% 
    .[!Asset_Class %in% c( "Total"),current_percent := round((Current_Value_Amount / sum(Current_Value_Amount,na.rm = T)) * 100 ,2)] %>%
    .[Asset_Class == "Total" , current_percent := 1] 

  

# Overall comparison ------------------------------------------------------

  
  overall_comparison_plot <- investment_comparison_data %>% filter(Asset_Class != "Total") %>% 
    pivot_longer(
      cols = c(invested_Amount,Current_Value_Amount),
      names_to = "Type",
      values_to = "Amount"
    ) %>% select(
      Asset_Class,Type,Amount
    ) %>% 
    ggplot(aes(x = Asset_Class, y = Amount, fill = Type)) +
    geom_col(position = "dodge") +
    geom_text(
      aes(label = round(Amount,0)),
      position = position_dodge(width = 0.9),
      hjust = 1.5,
      size = 3
    ) +
    coord_flip()+
    labs(
      title = "Investment Comparison by Asset Class",
      x = "Asset Class",
      y = "Amount",
      fill = "Type"
    ) +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold"),
      legend.position = "bottom"
    )+ scale_fill_discrete(
      labels = c("Invested Amount" , "Current Value Amount")
      
    )

# Investment Pie chart ----------------------------------------------------


  investment_pie_chart_plot <- investment_comparison_data %>% filter(Asset_Class != "Total") %>% select(
    Asset_Class,invested_percent) %>% 
    ggplot(aes(x = "", y = invested_percent, fill = Asset_Class)) +
    geom_col()+
    coord_polar(theta = "y")+
    theme_void()+
    geom_text(
      aes(label = paste0(round(invested_percent,2),
                         "%")),
      position = position_stack(vjust = 0.5),
      size = 4
    ) +labs(
      title = "Investment Distribution by Asset Class",
      fill = "Invested percent"
    ) + theme(
      plot.title = element_text(hjust = 0.5, face = "bold"),
      legend.position = "bottom"
    ) 
  

# current value pie chart -------------------------------------------------

  
  current_value_pie_chart_plot <- investment_comparison_data %>% filter(Asset_Class != "Total") %>% select(
    Asset_Class,current_percent) %>% 
    ggplot(aes(x = "", y = current_percent, fill = Asset_Class)) +
    geom_col()+
    coord_polar(theta = "y")+
    theme_void()+
    geom_text(
      aes(label = paste0(round(current_percent,2),
                         "%")),
      position = position_stack(vjust = 0.5),
      size = 4
    ) +labs(
      title = "Current value of Investment Distribution by Asset Class",
      fill = "Current Investment Value"
    ) + theme(
      plot.title = element_text(hjust = 0.5, face = "bold"),
      legend.position = "bottom"
    ) 
  

# FD investment  ---------------------------------------------------
fd_plot <- investment_comparison %>% filter(Asset_Class %in% c("investment_fd","emergency_fd","opportunity_fd")) %>% 
    mutate(
      invested_value= round((invested_Amount / sum(invested_Amount)) * 100 ,2),
      current_value= round((Current_Value_Amount / sum(Current_Value_Amount,na.rm = T)) * 100 ,2)
    ) %>% select(
      Asset_Class,invested_value,current_value
    ) %>% 
    pivot_longer(
      cols = c(invested_value,current_value),
      names_to = "Type",
      values_to = "Percent"
    ) %>% 
    ggplot(aes(x = "", y = Percent, fill = Asset_Class)) +
    geom_col()+coord_polar(theta = "y")+facet_grid(~Type)+
    theme_void()+
    geom_text(
      aes(label = paste0(round(Percent,2),
                         "%")),
      position = position_stack(vjust = 0.5),
      size = 4
    ) +
    labs(
      title = "FD Investment ",
      fill = "Investment Type"
    ) + theme(
      plot.title = element_text(hjust = 0.5, face = "bold"),
      legend.position = "bottom"
    )
    