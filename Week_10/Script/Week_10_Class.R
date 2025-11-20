### SZR
### 28/10/2025
### Week 10 Class
### Functional Programming

###########################################################################

## Load libraries
library(tidyverse)
library(palmerpenguins)
library(PNWColors)

## Data
df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm (10),
  d = rnorm (10)
)

df <- df %>%
  mutate(a = (a-min(a, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(a, na.rm = TRUE)),
         b = (b-min(b, na.rm = TRUE))/(max(b, na.rm = TRUE)-min(b, na.rm = TRUE)),
         c = (c-min(c, na.rm = TRUE))/(max(c, na.rm = TRUE)-min(c, na.rm = TRUE)),
         d = (d-min(a, na.rm = TRUE))/(max(d, na.rm = TRUE)-min(d, na.rm = TRUE)))


## F to C conversion
temp_C <- (temp_F - 32) * 5/9

farenheit_to_celsius  <- function(temp_F){
  temp_C <- (temp_F - 32) *5/9
  return(temp_C)
}

rescale01 <- function(x){
  value <- (x-min(x, na.rm = TRUE))/(max(x, na.rm = TRUE)-min(x, na.rm= TRUE))
}

farenheit_to_celsius(32)


## C to K conversion
temp_K <- (temp_Ce + 273.15)

celsius_to_kelvin <- function(temp_Ce){
  temp_K <- (temp_Ce +273.15)
  return(temp_K)
}

## Making plots into functions
# Plot
pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 

ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island))+
  geom_point()+
  geom_smooth(method = "lm")+ # add a linear model
  scale_color_manual("Island", values=pal)+   # use pretty colors and another example of how to manually change the legend title for colors
  theme_bw()

# Function
myplot <- function(data= penguins, x, y, lines = TRUE){ ## data = penguins sets data to only penguins
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  
if(lines == TRUE){
    ggplot(data, aes(x = {{x}}, y = {{y}}, color = island)) +
      geom_point() +
      geom_smooth(method = "lm")+
      scale_color_manual("Island", values=pal)+
      theme_bw()
}
else{
    ggplot(data, aes(x = {{x}}, y = {{y}}, color = island))+
      geom_point()+
      geom_smooth(method = "lm")+ # add a linear model
      scale_color_manual("Island", values=pal)+   # use pretty colors and another example of how to manually change the legend title for colors
      theme_bw()
}
}
2
