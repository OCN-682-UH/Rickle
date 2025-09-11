### Samantha Rickle
### 09/10/2025
### Week 3 video lecture

###############################################################################

## Load libraries
library(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce) ## follow specific instructions for custom git palettes
library(ggthemes)

### an aside
install.packages("praise")
library(praise)
praise() 

## Load data
## This data is already part of the package
glimpse(penguins)
head(penguins)
tail(penguins)
glimpse(diamonds) ## data set #2 in video

## Data analysis
## penguins data set
plot1 <- ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm, ## setting x and y
                     group = species, ## to group via species
                     color = species)) + ## to assign colors to variable
  geom_point() + ## to create a scatter plot
  geom_smooth(method = "lm") + ## to add a line of best fit ("lm" = linear line)
  labs(x = "Bill depth (mm)",
       y = "Bill length (mm)") +
scale_color_viridis_d() + ## to set the color theme
  scale_x_continuous(breaks = c(14,17,21),
                     labels = c("low", "medium", "high"))+ ## to add breaks in x axis
scale_color_manual(values = beyonce_palette(11)) + ## to set specific colors to beyonce
  theme_bw()+  ## to change the theme
  theme(axis.title = element_text(size = 20, ## to change the axis label size
                                  color = "red"),## to change the axis title color
        panel.background = element_rect(fill = "linen")) ## to change fill color
ggsave(here("Week_03", "output", "penguin.png"), ## to save the plot to a place
       width = 7, height = 5) ## to adjust dimentions of generated plot
 
plot1 

### diamonds data set
ggplot(diamonds, aes(carat, price)) +
  geom_point() +
  coord_trans(x = "log10", y = "log10") ## log transform x and y (can do both or just 1)
  
                       



  