# Week 06 Video2
SZR

<script src="Week_06_Video2_files/libs/kePrint-0.0.1/kePrint.js"></script>
<link href="Week_06_Video2_files/libs/lightable-0.0.1/lightable.css" rel="stylesheet" />

## Introduction

Today, we are learning about how to work with figures

## Libraries

``` r
library(tidyverse)
library(here)
library(palmerpenguins)
library(kableExtra)
```

# Plot

``` r
penguins %>%
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species))+
  geom_point()
```

<div id="fig-penguin2">

<img src="Week_06_Video2_files/figure-commonmark/fig-penguin2-1.png"
style="width:70.0%" data-fig-align="center" />

Figure 1: This is a figure showing bill length by bill depth

</div>

When you look at
<a href="#fig-penguin2" class="quarto-xref">Figure 1</a> you can see a
positive relationship

Practice manually inputting a table:

| Time   | Session  |   Topic |
|:-------|:--------:|--------:|
| *left* | *center* | *right* |
| 01:00  |    1     | Anatomy |
| 01:50  |          | *Break* |
| 02:00  |    2     |  Tables |
| 02:45  |          | *Break* |

``` r
penguins %>%
  group_by(species) %>%
  summarise(billmean = mean(bill_length_mm, na.rm = TRUE)) %>%
  kbl()  %>% ## this is a kable table
  kable_classic() %>% ## to make a kable theme
  row_spec(2, bold = TRUE, color = "white", background = "red") %>% ## highlighting row 2
  kable_styling(full_width = FALSE) ## make it not so big
```

<div id="tbl-penguin">

Table 1: My penguin table

<div class="cell-output-display">

| species   | billmean |
|:----------|---------:|
| Adelie    | 38.79139 |
| Chinstrap | 48.83382 |
| Gentoo    | 47.50488 |

</div>

</div>

<a href="#tbl-penguin" class="quarto-xref">Table 1</a> has information
on the mean bill length by species
