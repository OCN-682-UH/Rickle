# Week 11: Tidy Tuesday 1
SZR

<link href="Week_11_TidyTuesday_files/libs/htmltools-fill-0.5.8.1/fill.css" rel="stylesheet" />
<script src="Week_11_TidyTuesday_files/libs/htmlwidgets-1.6.4/htmlwidgets.js"></script>
<script src="Week_11_TidyTuesday_files/libs/plotly-binding-4.11.0/plotly.js"></script>
<script src="Week_11_TidyTuesday_files/libs/setprototypeof-0.1/setprototypeof.js"></script>
<script src="Week_11_TidyTuesday_files/libs/typedarray-0.1/typedarray.min.js"></script>
<script src="Week_11_TidyTuesday_files/libs/jquery-3.5.1/jquery.min.js"></script>
<link href="Week_11_TidyTuesday_files/libs/crosstalk-1.2.2/css/crosstalk.min.css" rel="stylesheet" />
<script src="Week_11_TidyTuesday_files/libs/crosstalk-1.2.2/js/crosstalk.min.js"></script>
<link href="Week_11_TidyTuesday_files/libs/plotly-htmlwidgets-css-2.11.1/plotly-htmlwidgets.css" rel="stylesheet" />
<script src="Week_11_TidyTuesday_files/libs/plotly-main-2.11.1/plotly-latest.min.js"></script>

- [Load Libraries](#load-libraries)
- [Load Data & Cleaning](#load-data--cleaning)
- [Plotting](#plotting)

# Load Libraries

<details class="code-fold">
<summary>Code</summary>

``` r
library(tidyverse)
library(dplyr)
library(plotly)
library(here)
```

</details>

# Load Data & Cleaning

This week’s Tidy Tuesday provides 2015 records of lead levels within
water from Flint Michigan according to the Michigan Department of
Environment (MDEQ) and Virginia Tech (VT).

<details class="code-fold">
<summary>Code</summary>

``` r
tuesdata <- tidytuesdayR::tt_load(2025, week = 44)

flint_mdeq <- tuesdata$flint_mdeq
flint_vt <- tuesdata$flint_vt

combined <- flint_mdeq %>%
  select(sample, lead_mdeq = lead) %>%
  left_join(flint_vt, by = "sample") %>%
  rename(lead_vt = lead) %>%
  arrange(sample)
```

</details>

# Plotting

<details class="code-fold">
<summary>Code</summary>

``` r
mdeq_color <- "#D55E00" ## creating an orange color vector for mdeq data
vt_color   <- "#0072B2" ## creating a blue color vector for vt data

flint_lead_levels <- plot_ly(combined) %>%
  add_trace( ## first working with mdeq data
    x = ~sample, 
    y = ~lead_mdeq,
    type = "scatter", mode = "lines+markers", ## setting point type and adding lines & markers
    name = "MDEQ", ## naming the line
    line = list(color = mdeq_color, width = 2), ## using the color vector for the line and adjusting width
    marker = list(color = mdeq_color, size = 6), ## making smaller point size with same color vector
    hoverinfo = "text", ## adding hover info
    text = ~paste0( ## setting the text info
      "<b>Sample:</b> ", sample,
      "<br><b>MDEQ Lead:</b> ", lead_mdeq, " ppb"
    )) %>%
  add_trace( ## now working with vt data, same process as above
    x = ~sample, 
    y = ~lead_vt,
    type = "scatter", mode = "lines+markers",
    name = "VT",
    line = list(color = vt_color, width = 2),
    marker = list(color = vt_color, size = 6),
    hoverinfo = "text",
    text = ~paste0(
      "<b>Sample:</b> ", sample,
      "<br><b>VT Lead:</b> ", lead_vt, " ppb"
    )) %>%
  layout(
    title = "Lead Levels by Sample (Interactive Comparison: MDEQ vs VT)",
    xaxis = list(title = "Sample ID"),
    yaxis = list(title = "Lead (ppb)"),
    hoverlabel = list(bgcolor = "white", font = list(size = 14)))

htmlwidgets::saveWidget(
  widget = flint_lead_levels,
  file = here("Week_11", "TidyTuesday", "Output", "flint_water.html")
)

flint_lead_levels ## so we can see it here too :D
```

</details>

<div class="plotly html-widget html-fill-item" id="htmlwidget-e5458cc9308950cd22f1" style="width:672px;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-e5458cc9308950cd22f1">{"x":{"visdat":{"115d339833732":["function () ","plotlyVisDat"]},"cur_data":"115d339833732","attrs":{"115d339833732":{"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"x":{},"y":{},"type":"scatter","mode":"lines+markers","name":"MDEQ","line":{"color":"#D55E00","width":2},"marker":{"color":"#D55E00","size":6},"hoverinfo":"text","text":{},"inherit":true},"115d339833732.1":{"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"x":{},"y":{},"type":"scatter","mode":"lines+markers","name":"VT","line":{"color":"#0072B2","width":2},"marker":{"color":"#0072B2","size":6},"hoverinfo":"text","text":{},"inherit":true}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"title":"Lead Levels by Sample (Interactive Comparison: MDEQ vs VT)","xaxis":{"domain":[0,1],"automargin":true,"title":"Sample ID"},"yaxis":{"domain":[0,1],"automargin":true,"title":"Lead (ppb)"},"hoverlabel":{"bgcolor":"white","font":{"size":14}},"hovermode":"closest","showlegend":true},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"x":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71],"y":[0,104,10,6,5,0,3,0,13,4,8,6,2,1,1,0,2,7,3,5,0,5,5,42,22,8,20,6,2,5,3,2,3,4,21,7,3,42,0,7,29,18,1,2,3,1,5,0,3,10,2,5,2,3,0,3,9,11,0,0,3,6,2,0,2,0,2,0,3,5,2],"type":"scatter","mode":"lines+markers","name":"MDEQ","line":{"color":"#D55E00","width":2},"marker":{"color":"#D55E00","size":6,"line":{"color":"rgba(31,119,180,1)"}},"hoverinfo":["text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text"],"text":["<b>Sample:<\/b> 1<br><b>MDEQ Lead:<\/b> 0 ppb","<b>Sample:<\/b> 2<br><b>MDEQ Lead:<\/b> 104 ppb","<b>Sample:<\/b> 3<br><b>MDEQ Lead:<\/b> 10 ppb","<b>Sample:<\/b> 4<br><b>MDEQ Lead:<\/b> 6 ppb","<b>Sample:<\/b> 5<br><b>MDEQ Lead:<\/b> 5 ppb","<b>Sample:<\/b> 6<br><b>MDEQ Lead:<\/b> 0 ppb","<b>Sample:<\/b> 7<br><b>MDEQ Lead:<\/b> 3 ppb","<b>Sample:<\/b> 8<br><b>MDEQ Lead:<\/b> 0 ppb","<b>Sample:<\/b> 9<br><b>MDEQ Lead:<\/b> 13 ppb","<b>Sample:<\/b> 10<br><b>MDEQ Lead:<\/b> 4 ppb","<b>Sample:<\/b> 11<br><b>MDEQ Lead:<\/b> 8 ppb","<b>Sample:<\/b> 12<br><b>MDEQ Lead:<\/b> 6 ppb","<b>Sample:<\/b> 13<br><b>MDEQ Lead:<\/b> 2 ppb","<b>Sample:<\/b> 14<br><b>MDEQ Lead:<\/b> 1 ppb","<b>Sample:<\/b> 15<br><b>MDEQ Lead:<\/b> 1 ppb","<b>Sample:<\/b> 16<br><b>MDEQ Lead:<\/b> 0 ppb","<b>Sample:<\/b> 17<br><b>MDEQ Lead:<\/b> 2 ppb","<b>Sample:<\/b> 18<br><b>MDEQ Lead:<\/b> 7 ppb","<b>Sample:<\/b> 19<br><b>MDEQ Lead:<\/b> 3 ppb","<b>Sample:<\/b> 20<br><b>MDEQ Lead:<\/b> 5 ppb","<b>Sample:<\/b> 21<br><b>MDEQ Lead:<\/b> 0 ppb","<b>Sample:<\/b> 22<br><b>MDEQ Lead:<\/b> 5 ppb","<b>Sample:<\/b> 23<br><b>MDEQ Lead:<\/b> 5 ppb","<b>Sample:<\/b> 24<br><b>MDEQ Lead:<\/b> 42 ppb","<b>Sample:<\/b> 25<br><b>MDEQ Lead:<\/b> 22 ppb","<b>Sample:<\/b> 26<br><b>MDEQ Lead:<\/b> 8 ppb","<b>Sample:<\/b> 27<br><b>MDEQ Lead:<\/b> 20 ppb","<b>Sample:<\/b> 28<br><b>MDEQ Lead:<\/b> 6 ppb","<b>Sample:<\/b> 29<br><b>MDEQ Lead:<\/b> 2 ppb","<b>Sample:<\/b> 30<br><b>MDEQ Lead:<\/b> 5 ppb","<b>Sample:<\/b> 31<br><b>MDEQ Lead:<\/b> 3 ppb","<b>Sample:<\/b> 32<br><b>MDEQ Lead:<\/b> 2 ppb","<b>Sample:<\/b> 33<br><b>MDEQ Lead:<\/b> 3 ppb","<b>Sample:<\/b> 34<br><b>MDEQ Lead:<\/b> 4 ppb","<b>Sample:<\/b> 35<br><b>MDEQ Lead:<\/b> 21 ppb","<b>Sample:<\/b> 36<br><b>MDEQ Lead:<\/b> 7 ppb","<b>Sample:<\/b> 37<br><b>MDEQ Lead:<\/b> 3 ppb","<b>Sample:<\/b> 38<br><b>MDEQ Lead:<\/b> 42 ppb","<b>Sample:<\/b> 39<br><b>MDEQ Lead:<\/b> 0 ppb","<b>Sample:<\/b> 40<br><b>MDEQ Lead:<\/b> 7 ppb","<b>Sample:<\/b> 41<br><b>MDEQ Lead:<\/b> 29 ppb","<b>Sample:<\/b> 42<br><b>MDEQ Lead:<\/b> 18 ppb","<b>Sample:<\/b> 43<br><b>MDEQ Lead:<\/b> 1 ppb","<b>Sample:<\/b> 44<br><b>MDEQ Lead:<\/b> 2 ppb","<b>Sample:<\/b> 45<br><b>MDEQ Lead:<\/b> 3 ppb","<b>Sample:<\/b> 46<br><b>MDEQ Lead:<\/b> 1 ppb","<b>Sample:<\/b> 47<br><b>MDEQ Lead:<\/b> 5 ppb","<b>Sample:<\/b> 48<br><b>MDEQ Lead:<\/b> 0 ppb","<b>Sample:<\/b> 49<br><b>MDEQ Lead:<\/b> 3 ppb","<b>Sample:<\/b> 50<br><b>MDEQ Lead:<\/b> 10 ppb","<b>Sample:<\/b> 51<br><b>MDEQ Lead:<\/b> 2 ppb","<b>Sample:<\/b> 52<br><b>MDEQ Lead:<\/b> 5 ppb","<b>Sample:<\/b> 53<br><b>MDEQ Lead:<\/b> 2 ppb","<b>Sample:<\/b> 54<br><b>MDEQ Lead:<\/b> 3 ppb","<b>Sample:<\/b> 55<br><b>MDEQ Lead:<\/b> 0 ppb","<b>Sample:<\/b> 56<br><b>MDEQ Lead:<\/b> 3 ppb","<b>Sample:<\/b> 57<br><b>MDEQ Lead:<\/b> 9 ppb","<b>Sample:<\/b> 58<br><b>MDEQ Lead:<\/b> 11 ppb","<b>Sample:<\/b> 59<br><b>MDEQ Lead:<\/b> 0 ppb","<b>Sample:<\/b> 60<br><b>MDEQ Lead:<\/b> 0 ppb","<b>Sample:<\/b> 61<br><b>MDEQ Lead:<\/b> 3 ppb","<b>Sample:<\/b> 62<br><b>MDEQ Lead:<\/b> 6 ppb","<b>Sample:<\/b> 63<br><b>MDEQ Lead:<\/b> 2 ppb","<b>Sample:<\/b> 64<br><b>MDEQ Lead:<\/b> 0 ppb","<b>Sample:<\/b> 65<br><b>MDEQ Lead:<\/b> 2 ppb","<b>Sample:<\/b> 66<br><b>MDEQ Lead:<\/b> 0 ppb","<b>Sample:<\/b> 67<br><b>MDEQ Lead:<\/b> 2 ppb","<b>Sample:<\/b> 68<br><b>MDEQ Lead:<\/b> 0 ppb","<b>Sample:<\/b> 69<br><b>MDEQ Lead:<\/b> 3 ppb","<b>Sample:<\/b> 70<br><b>MDEQ Lead:<\/b> 5 ppb","<b>Sample:<\/b> 71<br><b>MDEQ Lead:<\/b> 2 ppb"],"error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71],"y":[0.34399999999999997,0.34899999999999998,0.40000000000000002,0.40999999999999998,0.438,0.47499999999999998,0.5,0.5,0.501,0.50700000000000001,0.54300000000000004,0.54800000000000004,0.55200000000000005,0.63900000000000001,0.64000000000000001,0.68400000000000005,0.69999999999999996,0.70799999999999996,0.71899999999999997,0.73899999999999999,0.753,0.79300000000000004,0.80000000000000004,0.80000000000000004,0.80000000000000004,0.82299999999999995,0.82799999999999996,0.83199999999999996,0.84599999999999997,0.86599999999999999,0.90000000000000002,0.90600000000000003,0.91500000000000004,0.92200000000000004,0.94799999999999995,0.95599999999999996,0.96499999999999997,0.97399999999999998,0.97699999999999998,0.98999999999999999,1.032,1.083,1.1000000000000001,1.1000000000000001,1.1000000000000001,1.111,1.1140000000000001,1.1319999999999999,1.1519999999999999,1.1539999999999999,1.1659999999999999,1.1739999999999999,1.1830000000000001,1.2,1.2030000000000001,1.224,1.2290000000000001,1.29,1.2929999999999999,1.329,1.3440000000000001,1.3799999999999999,1.3859999999999999,1.403,1.4670000000000001,1.4690000000000001,1.492,1.571,1.585,1.621,1.6259999999999999],"type":"scatter","mode":"lines+markers","name":"VT","line":{"color":"#0072B2","width":2},"marker":{"color":"#0072B2","size":6,"line":{"color":"rgba(255,127,14,1)"}},"hoverinfo":["text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text"],"text":["<b>Sample:<\/b> 1<br><b>VT Lead:<\/b> 0.344 ppb","<b>Sample:<\/b> 2<br><b>VT Lead:<\/b> 0.349 ppb","<b>Sample:<\/b> 3<br><b>VT Lead:<\/b> 0.4 ppb","<b>Sample:<\/b> 4<br><b>VT Lead:<\/b> 0.41 ppb","<b>Sample:<\/b> 5<br><b>VT Lead:<\/b> 0.438 ppb","<b>Sample:<\/b> 6<br><b>VT Lead:<\/b> 0.475 ppb","<b>Sample:<\/b> 7<br><b>VT Lead:<\/b> 0.5 ppb","<b>Sample:<\/b> 8<br><b>VT Lead:<\/b> 0.5 ppb","<b>Sample:<\/b> 9<br><b>VT Lead:<\/b> 0.501 ppb","<b>Sample:<\/b> 10<br><b>VT Lead:<\/b> 0.507 ppb","<b>Sample:<\/b> 11<br><b>VT Lead:<\/b> 0.543 ppb","<b>Sample:<\/b> 12<br><b>VT Lead:<\/b> 0.548 ppb","<b>Sample:<\/b> 13<br><b>VT Lead:<\/b> 0.552 ppb","<b>Sample:<\/b> 14<br><b>VT Lead:<\/b> 0.639 ppb","<b>Sample:<\/b> 15<br><b>VT Lead:<\/b> 0.64 ppb","<b>Sample:<\/b> 16<br><b>VT Lead:<\/b> 0.684 ppb","<b>Sample:<\/b> 17<br><b>VT Lead:<\/b> 0.7 ppb","<b>Sample:<\/b> 18<br><b>VT Lead:<\/b> 0.708 ppb","<b>Sample:<\/b> 19<br><b>VT Lead:<\/b> 0.719 ppb","<b>Sample:<\/b> 20<br><b>VT Lead:<\/b> 0.739 ppb","<b>Sample:<\/b> 21<br><b>VT Lead:<\/b> 0.753 ppb","<b>Sample:<\/b> 22<br><b>VT Lead:<\/b> 0.793 ppb","<b>Sample:<\/b> 23<br><b>VT Lead:<\/b> 0.8 ppb","<b>Sample:<\/b> 24<br><b>VT Lead:<\/b> 0.8 ppb","<b>Sample:<\/b> 25<br><b>VT Lead:<\/b> 0.8 ppb","<b>Sample:<\/b> 26<br><b>VT Lead:<\/b> 0.823 ppb","<b>Sample:<\/b> 27<br><b>VT Lead:<\/b> 0.828 ppb","<b>Sample:<\/b> 28<br><b>VT Lead:<\/b> 0.832 ppb","<b>Sample:<\/b> 29<br><b>VT Lead:<\/b> 0.846 ppb","<b>Sample:<\/b> 30<br><b>VT Lead:<\/b> 0.866 ppb","<b>Sample:<\/b> 31<br><b>VT Lead:<\/b> 0.9 ppb","<b>Sample:<\/b> 32<br><b>VT Lead:<\/b> 0.906 ppb","<b>Sample:<\/b> 33<br><b>VT Lead:<\/b> 0.915 ppb","<b>Sample:<\/b> 34<br><b>VT Lead:<\/b> 0.922 ppb","<b>Sample:<\/b> 35<br><b>VT Lead:<\/b> 0.948 ppb","<b>Sample:<\/b> 36<br><b>VT Lead:<\/b> 0.956 ppb","<b>Sample:<\/b> 37<br><b>VT Lead:<\/b> 0.965 ppb","<b>Sample:<\/b> 38<br><b>VT Lead:<\/b> 0.974 ppb","<b>Sample:<\/b> 39<br><b>VT Lead:<\/b> 0.977 ppb","<b>Sample:<\/b> 40<br><b>VT Lead:<\/b> 0.99 ppb","<b>Sample:<\/b> 41<br><b>VT Lead:<\/b> 1.032 ppb","<b>Sample:<\/b> 42<br><b>VT Lead:<\/b> 1.083 ppb","<b>Sample:<\/b> 43<br><b>VT Lead:<\/b> 1.1 ppb","<b>Sample:<\/b> 44<br><b>VT Lead:<\/b> 1.1 ppb","<b>Sample:<\/b> 45<br><b>VT Lead:<\/b> 1.1 ppb","<b>Sample:<\/b> 46<br><b>VT Lead:<\/b> 1.111 ppb","<b>Sample:<\/b> 47<br><b>VT Lead:<\/b> 1.114 ppb","<b>Sample:<\/b> 48<br><b>VT Lead:<\/b> 1.132 ppb","<b>Sample:<\/b> 49<br><b>VT Lead:<\/b> 1.152 ppb","<b>Sample:<\/b> 50<br><b>VT Lead:<\/b> 1.154 ppb","<b>Sample:<\/b> 51<br><b>VT Lead:<\/b> 1.166 ppb","<b>Sample:<\/b> 52<br><b>VT Lead:<\/b> 1.174 ppb","<b>Sample:<\/b> 53<br><b>VT Lead:<\/b> 1.183 ppb","<b>Sample:<\/b> 54<br><b>VT Lead:<\/b> 1.2 ppb","<b>Sample:<\/b> 55<br><b>VT Lead:<\/b> 1.203 ppb","<b>Sample:<\/b> 56<br><b>VT Lead:<\/b> 1.224 ppb","<b>Sample:<\/b> 57<br><b>VT Lead:<\/b> 1.229 ppb","<b>Sample:<\/b> 58<br><b>VT Lead:<\/b> 1.29 ppb","<b>Sample:<\/b> 59<br><b>VT Lead:<\/b> 1.293 ppb","<b>Sample:<\/b> 60<br><b>VT Lead:<\/b> 1.329 ppb","<b>Sample:<\/b> 61<br><b>VT Lead:<\/b> 1.344 ppb","<b>Sample:<\/b> 62<br><b>VT Lead:<\/b> 1.38 ppb","<b>Sample:<\/b> 63<br><b>VT Lead:<\/b> 1.386 ppb","<b>Sample:<\/b> 64<br><b>VT Lead:<\/b> 1.403 ppb","<b>Sample:<\/b> 65<br><b>VT Lead:<\/b> 1.467 ppb","<b>Sample:<\/b> 66<br><b>VT Lead:<\/b> 1.469 ppb","<b>Sample:<\/b> 67<br><b>VT Lead:<\/b> 1.492 ppb","<b>Sample:<\/b> 68<br><b>VT Lead:<\/b> 1.571 ppb","<b>Sample:<\/b> 69<br><b>VT Lead:<\/b> 1.585 ppb","<b>Sample:<\/b> 70<br><b>VT Lead:<\/b> 1.621 ppb","<b>Sample:<\/b> 71<br><b>VT Lead:<\/b> 1.626 ppb"],"error_y":{"color":"rgba(255,127,14,1)"},"error_x":{"color":"rgba(255,127,14,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>

This plot shows the drastic differences in lead measurements reported by
MDEQ vs VT.

The **NEW SKILL** I learned during this Tidy Tuesday was creating an
**interactive plot using the *plotly* package**.
