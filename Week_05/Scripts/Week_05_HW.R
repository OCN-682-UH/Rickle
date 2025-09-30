### Samantha Rickle
### 22/09/2025
### Week 5
### Homework

####################################################################################

### libraries
library(tidyverse)
library(here)
library(lubridate) 

### data
cond_data <- read_csv(here("Week_05/Data/CondData.csv"))
depth_data <- read.csv(here("Week_05/Data/DepthData.csv"))

### analysis
combined_cond_depth <- cond_data %>%
  mutate(date = mdy_hms(date), ## reordering datetime
         date = round_date(date, "10 seconds")) %>% ## rounding time to nearest 10s
  inner_join(depth_data %>%
              mutate(date = ymd_hms(date)),## still have to convert date even if already in correct format?
             by = "date") %>%
  mutate(minute = floor_date(date, "minute")) %>% ## adding a minute column
  group_by(minute) %>% ## grouping by minute
  summarise( ## calculating averages
    date_mean = mean(date, na.rm = TRUE), 
    depth_mean = mean(Depth, na.rm = TRUE),
    temp_mean = mean(Temperature, na.rm = TRUE),
    sal_mean = mean(Salinity, na.rm = TRUE)) %>%
  pivot_longer(cols = depth_mean:sal_mean, ## had to remove date average to work
               names_to = "parameter",
               values_to = "value")

ggplot(combined_cond_depth, aes(x = minute, y = value)) + ## plotting minute vs value from above data
  geom_point()+
  facet_wrap(~parameter, scales = "free_y") + ## faceting based on the variable
  theme_classic() + ## simplifying the theme
  labs (x = "Minute",
        y = "Averaged Value",
        title = "Average Depth, Salinity, and Temperature Measured per Minute") ## changing labels and title


