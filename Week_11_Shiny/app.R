#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#
#############################################################################

### Load Libraries
library(shiny)
library(dplyr)
library(readr)
library(DT)
library(here)
library(rsconnect)

### Load Data
ccz <- read_csv(here("Week_11_Shiny", "ccz_target_cleaned.csv"))

# Create the list of depth levels from your categorical depth column
depth_levels <- ccz %>%
  distinct(depth_range_m) %>%
  pull(depth_range_m) ## converts into vector to work in shiny

### UI
ui <- fluidPage(
  checkboxGroupInput( ## setting app to interactive checkboxes
    inputId = "depth_cat",
    label   = "Choose depth ranges:",
    choices = depth_levels,
    selected = depth_levels
  ),
  h3(textOutput("total_n")), ## what is displayed
  tableOutput("ltu_table")
)

### Server
server <- function(input, output, session) {
  filtered_data <- reactive({ ## updates output based on checked boxes
    req(input$depth_cat) ## waits for selection
    subset(ccz, depth_range_m %in% input$depth_cat)
  })
  output$total_n <- renderText({
    paste("Total records in selected depth range(s):", nrow(filtered_data()))
  })
  output$ltu_table <- renderTable({
    filtered_data() %>%
      count(LTU, name = "n") %>%
      arrange(desc(n))
  })
}


### Run the app
shinyApp(ui = ui, server = server)

