### Samantha Rickle
### 22/09/2025
### Week 4 HW
### tidyr 

####################################################################################

### Libraries 
library(tidyverse)
library(here)
library(ggthemes)

chemical <- read_csv(here("Week_04/Data/chemicaldata_maunalua.csv"))
chem_clean_hw <- chemical %>%
  drop_na() %>% ## to filter out NAs, BUT can also filter(complete.cases(.))
  separate(col = Tide_time, ## separating Tide_time into 2 columns 
           into = c("Tide","Time"), ## named Tide and Time
           sep = "_") %>% ## tells us where the data is separating
  pivot_longer(cols = Temp_in:percent_sgd, ## to select columns to be pivoted
               names_to = "Variables", ## to rename this column
               values_to = "Values") %>% ## to rename corresponding output column
  group_by(Variables, Values, Site) %>% ## to evaluate summary statistics based on Variables, Zone and Season
  summarise(Param_means = mean(Values, na.rm = TRUE),
            Param_vars = var(Values, na.rm = TRUE), 
            Param_sd = sd(Values, na.rm = TRUE)) %>%
  write_csv(here("Week_04","Output","HW_summary.csv"))

chem_long_plot <- chem_clean_hw %>% 
  ggplot(aes(x = Site, y = Values)) + ## plotting site vs values
  geom_jitter(alpha = 0.5) + ## to add jitter points under violin
  geom_violin(alpha = 0.80) + ## setting plot type to violin
  facet_wrap(~Variables, ## faceting plot based on the variables column
             scales = "free")## to make axis scales independent of each other
  
ggsave(here("Week_04", "Output", "Chem_Data_Violin.png")) ## saving the plot :-)

 
  





