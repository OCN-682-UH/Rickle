### SZR
### 17/11/2025
### Week 11 HW
### Shiny App

library(shiny)
library(tidytuesdayR)
library(dplyr)
library(ggplot2)
library(stringr)   # for word()

# ---- Load data ONCE, outside the app ----
tuesdata <- tidytuesdayR::tt_load(2025, week = 35)
frogs <- tuesdata$frogID_data

# Make genus + species columns from scientificName
frogs <- frogs |>
  mutate(
    genus   = word(scientificName, 1),
    species = word(scientificName, 2)
  )

# ---- UI ----
ui <- fluidPage(
  titlePanel("FrogID observations (TidyTuesday 2025, Week 35)"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "species",
        label   = "Choose a species:",
        choices = sort(unique(frogs$species)),
        selected = "signifera"  # you can change this
      ),
      checkboxInput(
        inputId = "show_data",
        label   = "Show raw data table",
        value   = FALSE
      )
    ),
    
    mainPanel(
      plotOutput("state_plot"),
      br(),
      conditionalPanel(
        condition = "input.show_data == true",
        h4("Raw data for selected species"),
        tableOutput("frog_table")
      )
    )
  )
)

# ---- SERVER ----
server <- function(input, output, session) {
  
  # Filtered data based on species input
  filtered_frogs <- reactive({
    frogs |> 
      filter(species == input$species)
  })
  
  # Bar plot: number of records by stateProvince
  output$state_plot <- renderPlot({
    dat <- filtered_frogs()
    
    ggplot(dat, aes(x = stateProvince)) +
      geom_bar() +
      labs(
        x = "State / Territory",
        y = "Number of records",
        title = paste("Frog observations for species:", input$species)
      ) +
      theme_minimal()
  })
  
  # Optional table of the raw data
  output$frog_table <- renderTable({
    filtered_frogs() |>
      select(
        occurrenceID, eventDate, eventTime, 
        scientificName, stateProvince, decimalLatitude, decimalLongitude
      )
  })
}

# ---- Run the app ----
shinyApp(ui, server)

