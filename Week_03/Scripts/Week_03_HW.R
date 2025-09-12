### Samantha Rickle
### 11/09/2025
### Week 3 Homework

###############################################################################

### Load libraries
library(palmerpenguins)
library(tidyverse)
library(here)
library(ggthemes)
library("RColorBrewer")

### Load data
glimpse(penguins) 

### Data analysis
ggplot(data=penguins, ## plotting using penguins data
       mapping = aes(x = species, 
                     y = body_mass_g, ## setting the x and y variables
                     color = species)) + ## setting the color by species
  geom_boxplot(alpha = 0.75) + ## displaying via boxplot
  geom_jitter() + ## overlaying jitter points
  labs(title = "Body Mass According to Species",
       x = "Species",
       y = "Body Mass (g)") + ## setting title and axis labels
  scale_color_brewer(palette = "Dark2") + ## choosing a color palette
  theme_bw() + ## setting background theme to black and white
  theme(legend.position = "none", ## removing legenc bc the bars are already labeled
        title = element_text(size = 20,
                             color = "dark blue"), ## changing the title text size and color
        axis.title = element_text(size = 15, 
                                  color = "dark blue")) ## changing the label text size and color
ggsave(here("Week_03", "Output", "penguin_hw.png")) ## saving the plot :-)

       