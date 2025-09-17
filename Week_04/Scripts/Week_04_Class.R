### Samantha Rickle
### 16/09/2025
### Week 4 practice

################################################################################

### libraries
library(palmerpenguins)
library(tidyverse)
library(here)

### load data
glimpse(penguins)

### analysis
filter(.data = penguins, sex == "female")

filter(.data = penguins, year == "2008") ## to filter out data aside from the year 2008
filter(.data = penguins, body_mass_g > "5000") ## to filter out data with mass greater than 5000
filter(.data = penguins, year == 2008|2009) ## to filter for 2008 OR 2009
filter(.data = penguins, island != "Dream") ## to filters for islands other than Dream
filter(.data = penguins, species %in% c("Adelie","Gentoo")) ## to filter for specific species

data2 <- mutate(.data = penguins,
              length_body_mass = body_mass_g + flipper_length_mm) ## to create a new column with length + mass
data2 <- mutate(penguins,
                big_small = ifelse(body_mass_g > 4000, "big", "small")) ## to create new column with mass > 4000 = big, < 400 = small

penguins %>% ## to use penguins data
  filter(sex == "female") %>% ## to select females
  mutate(log_mass = log(body_mass_g)) ## to calculate log biomass

penguins %>%
  group_by(island) %>%
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE),
            min_flipper = min(flipper_length_mm, na.rm=TRUE))

                
            