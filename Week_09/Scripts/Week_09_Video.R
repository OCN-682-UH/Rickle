### 27/10/2025
### SZR
### Week 9 video
### Working with Factors

############################################################

### Load Libraries
library(tidyverse)
library(here)

### Loading Data
income_mean <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_mean.csv')

### Analysis
## Starwars
star_counts <- starwars %>%
  filter(!is.na(species)) %>% ## removing NAs
  mutate(species = fct_lump(species, n = 3)) %>% ## lumping rare species into "other" to focus on main species
  count(species, sort = TRUE) %>% ## making counts of species
  mutate(species = factor(species)) %>% ## to make species a factor
  filter(n>3) %>% ## only keeping species that have more than 3
  droplevels() %>% ## to drop extra levels
  mutate(species = fct_recode(species, "Humanoid" = "Human")) ## renaming factor

star_counts %>% 
  ggplot(aes(x = fct_reorder(species, n, .desc = TRUE), y = n)) + ## to reorder the factor of species
  geom_col()

## Income
total_income <- income_mean %>%
  group_by(year, income_quintile) %>%
  summarise(income_dollars_sum = sum(income_dollars)) %>%
  mutate(income_quintile = factor(income_quintile)) ## make it a factor

total_income %>%
  ggplot(aes(x = year, y = income_dollars_sum,
             color = fct_reorder2(income_quintile, year, income_dollars_sum))) + ## reordering income quintile by year and income dollars some
  geom_line() +
  labs(color = "income quantile")
