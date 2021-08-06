
month.abb[1:12]

data_rain <- data.frame(months = month.abb[1:12],
                   avg_rain = c(9,10,18,46,93,61,75,85,90,180,103,31))
      
str(data_rain)   


data_rain %>%  mutate(months = fct_relevel(months, 
                                         "Jan", "Feb", "Mar", "Apr","May","Jun", "Jul","Aug","Sep","Oct","Nov", "Dec")) %>% 
  mutate(pct_rain_salem = avg_rain/sum(avg_rain)) %>%
  group_by(months) %>% 
  ggplot(aes(months, pct_rain_salem)) +
  geom_line(group = 1) + 
  geom_point(aes(size = pct_rain_salem)) + 
  theme_minimal() + 
  scale_y_continuous(labels = percent_format())+ 
  scale_size_continuous(guide = "none") + 
  labs(x = "Months", y = "% days rain in Months")
