# Load libraries
library(shiny)
library(tidyverse)
library(DT)
library(ggplot2)
library(shinythemes)
library(here)
library(shinydashboard)


netflix <- read_csv(here("data/titles.csv"))

ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel("Netflix Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      tags$div(
        img(src = "data:image/png;base64,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", height = "100px")
      ),      
      selectInput("type", "Select Show Type:", choices = c("All", unique(netflix$type)), selected = "All"),
      selectInput("hist_variable", "Select Histogram Variable:", choices = c("IMDb Score" = "imdb_score", "Runtime" = "runtime"), selected = "imdb_score"),
      sliderInput("imdb_score", "IMDb Score Range:", min = min(netflix$imdb_score, na.rm = TRUE),
                  max = max(netflix$imdb_score, na.rm = TRUE), value = c(5, 9.6)),
      textInput("search", "Search:", ""),
      actionButton("update", "Update")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Overview",
                 fluidRow(
                   valueBoxOutput("totalTitles"),
                   valueBoxOutput("avgImdb"),
                   valueBoxOutput("avgRuntime")
                 )
        ), 
        
        tabPanel("Visualizations", plotOutput("histogram")),
        tabPanel("Data Table", DTOutput("dataTable"))
      ) 
    )
  )
)


server <- function(input, output) {
  
  filtered_data <- reactive({
    data <- netflix %>% select(title, type, imdb_score, runtime, release_year)
    if (input$type != "All") {
      data <- data %>% filter(type == input$type)
    }
    data <- data %>% filter(imdb_score >= input$imdb_score[1], imdb_score <= input$imdb_score[2])
    if (input$search != "") {
      data <- data %>% filter(str_detect(title, regex(input$search, ignore_case = TRUE)))
    }
    return(data)
  })
  
  output$totalTitles <- renderValueBox({ valueBox(nrow(netflix), "Total Works") })
  output$avgImdb <- renderValueBox({ valueBox(round(mean(netflix$imdb_score, na.rm = TRUE), 2), "Avg IMDb Score") })
  output$avgRuntime <- renderValueBox({ valueBox(round(mean(netflix$runtime, na.rm = TRUE), 2), "Avg Runtime (mins)") })
  
  
  output$histogram <- renderPlot({
    data <- filtered_data()
    ggplot(data, aes_string(x = input$hist_variable, fill = "type")) +
      geom_histogram(binwidth = 0.5, color = "black", alpha = 0.7, position = "identity") +
      geom_density(aes(y = ..count.. * 0.5, color = type), alpha = 0.5) +
      scale_fill_manual(values = c("MOVIE" = "blue", "SHOW" = "red")) +
      scale_color_manual(values = c("MOVIE" = "blue", "SHOW" = "red")) +
      labs(title = paste("Distribution of", input$hist_variable), x = input$hist_variable, y = "Count") +
      theme_minimal()
  })
  
  output$dataTable <- renderDT({
    datatable(filtered_data(), options = list(pageLength = 10, scrollX = TRUE, searching = FALSE))
  })
}

shinyApp(ui = ui, server = server)

