### Samantha Rickle
### 22/09/2025
### Week 4 HW
### tidyr 

####################################################################################

### Libraries 
library(tidyverse)
library(here)

chemical <- read.csv("/Users/samantharickle/Desktop/R Stuff/Rickle/Week_04/Data/chemicaldata_maunalua.csv")

chem_clean_hw <- chemical %>%
  drop_na() %>% ## to filter out NAs, BUT can also filter(complete.cases(.))
  separate(col = Tide_time, ## separating Tide_time into 2 columns 
           into = c("Tide","Time"), ## named Tide and Time
           sep = "_") ## tells us where the data is separating


chem_long_hw <- chem_clean_hw %>% 
  pivot_longer(cols = Site:Time, ## to select columns to be pivoted
               names_to = "Location Data", ## to name new column
               values_to = "Values") ## to name value column\

chem_wide_hw <- chem_clean_hw %>%
  pivot_wider(names_from = Time,
              values_from = Zone)

chem_wide <- chem_long %>% 
  pivot_wider(names_from = Variables, ## to pivot from long to wide data, choose column with names of new columns
              values_from = Values) ## select column with values