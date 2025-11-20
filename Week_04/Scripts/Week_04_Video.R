### Samantha Rickle
### 21/09/2025
### Week 4 Video lecture
### Data Wrangling: tidyr

####################################################################################

### Libraries 
library(tidyverse)
library(here)

### Data
chemical <- read.csv("/Users/samantharickle/Desktop/R Stuff/Rickle/Week_04/Data/chemicaldata_maunalua.csv")
glimpse(chemical)

## Analysis
chem_clean <- chemical %>%
  filter(complete.cases(.)) %>% ## filter out NAs
  separate(col = Tide_time, ## to select column
           into = c("Tide", "Time"), # to separate into 2 columns (needs "" bc columns dont exist yet)
           sep = "_", ## where to separate
           remove = FALSE) %>% ## to keep the original column
  unite(col = "Site_Zone", ## to create new column (needs "" bc it doesnt exist yet)
        c(Site,Zone), ## the columns being united
        sep = ".", ## separate by .
        remove = FALSE) ## to keep og

chem_long <- chem_clean %>%
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values")

chem_long %>% ## mean, variance, and standard deviation for site
  group_by(Variables, Site) %>% ## to group by select variables
  summarise(Param_means = mean(Values, na.rm = TRUE), ## get mean
            Param_vars = var(Values, na.rm = TRUE), ## get variance
            Param_sd = sd(Values, na.rm = TRUE)) ## get standard deviation

chem_long %>% ## " for zone
  group_by(Variables, Zone) %>% ## to group by select variables
  summarise(Param_means = mean(Values, na.rm = TRUE), ## get mean
            Param_vars = var(Values, na.rm = TRUE), ## get variance
            Param_sd = sd(Values, na.rm = TRUE)) ## get standard deviation

chem_long %>% ## " for tide
  group_by(Variables, Tide) %>% 
  summarise(Param_means = mean(Values, na.rm = TRUE),
            Param_vars = var(Values, na.rm = TRUE), 
            Param_sd = sd(Values, na.rm = TRUE)) 

chem_long %>% 
  ggplot(aes(x = Site, y = Values)) + ## plotting site vs values
  geom_boxplot()+ ## setting plot type
  facet_wrap(~Variables, ## faceting plot based on the variables column
             scales = "free") ## to make axis scales independent of each other

chem_wide <- chem_long %>% 
  pivot_wider(names_from = Variables, ## to pivot from long to wide data, choose column with names of new columns
              values_from = Values) ## select column with values

#################################################################################

chem_clean_wide <- chemical %>%
  drop_na() %>%
  separate(col = Tide_time,
           into = c("Tide","Time"),
           sep = "_",
           remove = FALSE) %>%
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values") %>%
  group_by(Variables, Site, Time) %>%
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>%
  pivot_wider(names_from = Variables,
              values_from = mean_vals) %>%
  write_csv(here("Week_04","Output","summary.csv"))

