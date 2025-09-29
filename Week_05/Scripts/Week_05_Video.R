### Samantha Rickle
### 22/09/2025
### Week 5
### lecture 5b 
### Data wrangling: lubridate dates and times  

####################################################################################

### libraries
library(tidyverse)
library(here)
library(lubridate) ## deals with dates and times

## lubridate practice
ymd("2021,02-24")
mdy("02/24/2021") ## to tell date format and convert to ISO
mdy("February 24 2021") 
dmy("24/02/2021")

ymd_hms("2021-02-24 10:22:20 PM")
mdy_hms("02/24/2021 22:22:20")
mdy_hm("February 24 2021 10:22 PM")
mdy_hm("02/24/2021 22:22:20") ## entered hm insetead of hms and got error

datetimes <- c("02/24/2021 22:22:20",
               "02/25/2021 11:21:10",
               "02/26/2021 8:01:52")
datetimes <- mdy_hms(datetimes) ## to reorder date format and save as vector
month(datetimes) ## to get month matrix
month(datetimes, label = TRUE) ## to get months spelled out

####################################################################################

## challenge, read in CondData and change all dates to datetime
cond_data <- read_csv(here("Week_05/Data/CondData.csv"))

cond_datetime <- mdy_hms(cond_data$date) ## creates a vector with ISO format, how to make a new column
cond_data$date <- mdy_hms(cond_data$date) ## transforms dates within data frame by using vector function 








