

library(tidyverse)
library(tidytuesdayR)
library(dplyr)
library(ggplot2)
library(extrafont)

athletes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-08-03/athletes.csv')



# number of sports each athlete won a medal in during the 1980 Paralympics

paralympics_1980 <- athletes %>%
  filter(year == "1980") %>%
  select(athlete, type) %>%
  group_by(athlete) %>%
  summarise(count = n_distinct(type)) %>%
  filter(count > 1)

# test above script to apply to entire athletes dataset

paralympics <- athletes %>%
  group_by(year, athlete) %>%
  summarise(count = n_distinct(type)) %>%
  filter(count > 1,
         athlete != "Great Britain")

# number of athletes who won a medal in more than one sport by year

paralympics_athlete_year <- paralympics %>%
  group_by(year) %>%
  summarise(athletes_by_sports = n_distinct(athlete))

#number of athletes who competed by year 

athlete_numbers <- athletes %>%
  group_by(year) %>%
  filter(athlete != "Great Britain") %>%
  summarise(total_athletes = n_distinct(athlete)) 

# join both datasets together & find percentage 

paralympics_together <- left_join(paralympics_athlete_year, athlete_numbers, by="year") %>%
  mutate(
    percentage = athletes_by_sports/total_athletes*100
  ) %>%
  round(digits = 2) 



ggplot(paralympics_together, 
       aes(
         x = year, y = percentage, type = "b"
       )) +
  geom_point(shape = 21,
             colour = "#0081C8",
             fill = "#00A651",
             size = 4) +
  geom_line(colour = "#EE334E") +
  geom_text(aes(label = percentage),
            nudge_y = 0.75,
            colour = "#0081C8") +
  scale_x_continuous(breaks = seq(1980, 2016, by = 4)) +
  scale_y_continuous(breaks = seq(0, 15, by = 1)) +
  labs(
    x = "Year",
    y = "% of athletes",
    title = "Percentage of Paralympic athletes who've won medals in more than one sport",
    subtitle = "This graph shows the percentage of athletes who won medals in more than one sport at each of the Paralympic Games",
    caption = "Data: IPC"
  ) +
  theme_minimal() +
    theme(plot.title = element_text(size = 12, hjust = 0.5)) +
  theme(plot.subtitle = element_text (size = 8, hjust = 0.5, face = "italic")) +
  theme(panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())


