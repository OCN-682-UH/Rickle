### Samantha Rickle
### 23/09/2025
### Week 5 Class
### Data Wrangling: Joins

################################################################################

### libraries
library(tidyverse)
library(here)
library(cowsay)

### data
# Environmental data
envirodata <- read_csv(here("Week_05", "Data", "site.characteristics.data.csv"))

# Thermal performance data
tpcdata <- read_csv(here("Week_05", "Data", "Topt_data.csv"))

envirodata_wide <- envirodata %>% ## changing envirodata to wide format
  pivot_wider(names_from = parameter.measured,
              values_from = values) %>%
  arrange(site.letter) ## to arrange in order by site letter (from here now on)

fulldata_left <- left_join(tpcdata, envirodata_wide) %>% ## to join envirodata and tpcdata (must be same fata format)
  relocate(where(is.numeric), .after = where(is.character)) ## to make all character columns left and numeric columns right

## to calculate mean and variance of combined collected data set by site
fulldata_long <- fulldata_left %>% ## changing combined fulldata to long form
  pivot_longer(c(E:substrate.cover), ## selecting columns to be pivoted
               names_to = "Variables", ## changing column names 
               values_to = "Values") %>%
  group_by(site.letter, Variables) %>% ## to group by site letter
  summarise(Param_means = mean(Values, na.rm = TRUE), ## to calculate mean and variance
            Param_vars = var(Values, na.rm = TRUE))

T1 <- tibble(Site.ID = c("A", "B", "C", "D"),
            temperature = c(14.1, 16.7, 15.2, 12.8))
T2 <-tibble(Site.ID = c("A", "B", "D", "E"),
            pH = c(7.3, 7.8, 8.1, 7.9))
left_join(T1, T2) ## keeps ABCD
right_join(T1, T2) ## keeps ABDE
inner_join(T1, T2) ## only keeps shared data columns
semi_join(T1, T2)

say("hello", by = "fish")
