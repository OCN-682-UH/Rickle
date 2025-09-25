### Samantha Rickle
### 16/09/2025
### Week 4 practice

################################################################################
###### Lecture Code

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
  drop_na(sex) %>%
  summarise(mean_bill_length = mean(bill_length_mm, na.rm=TRUE),
            min_flipper = max(bill_length_mm, na.rm=TRUE))
penguins %>%
  drop_na(sex) %>%
  ggplot(aes(x = sex, y = flipper_length_mm)) +
  geom_boxplot()
ggsave(here("Week_04", "Output", "penguin_lecture.png")) ## saving the plot

penguins %>% 
  group_by(species, island, sex) %>% ## to evaluate summary statistics based on selected variables
  summarise(Param_means = mean(body_mass_g, na.rm = TRUE),
            Param_vars = var(body_mass_g, na.rm = TRUE) 
  write_csv(here("Week_04","Output","HW_summary.csv"))

################################################################################

###### Lecture HW

### libraries
library(palmerpenguins)
library(tidyverse)
library(here)
library(ggplot2)

### load data
glimpse(penguins)

### analysis
penguins_female <- filter(.data = penguins, sex == "female") %>%
  mutate(log_mass = log(body_mass_g))

penguins_female %>%
select(c("island", "sex", "log_mass"))

ggplot(data = penguins_female, ## plotting using penguins data
       mapping = aes(x = species, 
                     y = log_mass, ## setting the x and y variables
                     color = species)) + ## setting the color by species
  geom_boxplot(alpha = 0.75) + ## displaying via boxplot
  geom_jitter() + ## overlaying jitter points
  labs(title = "Female Body Mass According to Species",
       x = "Species",
       y = "Body Mass (g)")  ## setting title and axis labels
ggsave(here("Week_04", "Output", "penguin_lecture_hw.png")) ## saving the plot
        
