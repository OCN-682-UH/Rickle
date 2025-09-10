### Samantha Rickle
### 09/09/2025
### Week 3 practice

################################################################################

### Load libraries
library(palmerpenguins)
library(tidyverse)
glimpse(penguins)

### Data
# Start with penguin dataframe, mapp bill depth to the x-axis
ggplot(data=penguins,
       mapping = aes (x = bill_depth_mm,
                      y = bill_length_mm,
                      color = species,
                      shape = island, ## changing shape of points
                      size = body_mass_g, ## changing size of points according to data
                      alpha = flipper_length_mm)) + ## changing transparency
  
  geom_point() +
  labs(title = "Bill depth and length",
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill depth (mm)", y= "Bill length (mm)",
       color = "Species",
       caption = "Palmer Station LTER / palmerpenguins package") +
  scale_color_viridis_d()

ggplot(penguins,
       aes(x = bill_depth_mm,
           y = bill_length_mm)) +
  geom_point()+
  facet_grid(species~sex) + ## to make a faceted plot
  guides(color = FALSE) ## takes away color or legend?

ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm)) + 
  geom_point() +
  facet_wrap(~ species, ncol = 2) + ## to make it 2 rows
  guides(color = FALSE)






  



