
### Week 8 Video Lecture
### SZR
### 21/10/2025
### Advanced Plotting

## Load Libraries
library(tidyverse)
library(here)
library(patchwork)
library(ggrepel)
library(gganimate)
library(magick)
library(palmerpenguins)

## Practice using patchwork
p1 <- penguins %>%
  ggplot(aes(x = body_mass_g,
             y = bill_length_mm,
             color = species))+
  geom_point()

p2 <- penguins %>%
  ggplot(aes(x = sex,
             y = body_mass_g,
             color = species)) +
  geom_jitter(width = 0.2)

p1 + p2 +
  plot_layout(guides = 'collect')+
  plot_annotation(tag_levels = 'A')

## Practice using ggrepel
ggplot(mtcars, aes(x = wt,
                   y = mpg,
                   label = rownames(mtcars))) +
  geom_text_repel() +
  geom_point(color = 'red')


## Practice with gganimate
penguins %>%
  ggplot(aes(x = body_mass_g,
             y = bill_depth_mm, 
             color = species)) +
  geom_point() +
  transition_states(
    year,
    transition_length= 2,
    state_length = 1
  )+
  ease_aes("sine-in-out")+
  labs(title = 'Year : {closest_state}') +
  anim_save(here("Week_08", "Output", "mypenguingif.gif"))

## Practice with magick package
penguin_pic <- image_read("https://pngimg.com/uploads/penguin/pinguin_PNG9.png")

penguins_plot <- penguins %>%
  ggplot(aes(x = body_mass_g,
             y = bill_depth_mm, 
             color = species)) +
  geom_point()

ggsave(here("Week_08", "Output", "Penguin_mass_length.png"))

penplot <- image_read(here("Week_08", "Output", "Penguin_mass_length.png"))
out <- image_composite(penplot, penguin_pic, offset= "+70+30")
animation <- image_animate(outgif, fps = 10, optimize = TRUE)

