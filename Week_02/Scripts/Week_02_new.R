### This is my first script. I am learning how to import data
### Created by Samantha Rickle
### Created on 2025-09-05

### Libraries
library(tidyverse)
library(here)

### Read in my data
weightdata<-read_csv(here("Week_02","Data","weightdata.csv"))

### Data Analysis 
head(weightdata) # looks at top 6 lines of data
tail(weightdata) # looks at the bottom 6 lines
view(weightdata) # shows entire data set
