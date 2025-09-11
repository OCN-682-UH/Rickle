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
ggplot(data=penguins,
       mapping = aes(x = species,
                     y = body_mass_g,
                     color = species)) +
  geom_boxplot(alpha = 0.75) +
  geom_jitter() +
  labs(title = "Body Mass According to Species",
       x = "Species",
       y = "Body Mass (g)") +
  scale_color_brewer(palette = "Dark2") +
  theme_bw() +
  theme(legend.position = "none",
        title = element_text(size = 20,
                             color = "dark blue"),
        axis.title = element_text(size = 15,
                                  color = "dark blue")) 
ggsave(here("Week_03", "Output", "penguin_hw.png"))

       