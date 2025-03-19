# Load libraries
library(shiny)
library(shinydashboard)
library(tidyverse)
library(DT)
library(ggplot2)
library(shinythemes)
library(here)

# Load data
netflix <- read_csv(here("data/titles.csv"))

ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel("Netflix Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      tags$div(
        img(src = "data:image/png;base64,...", height = "100px")
      ),      
      selectInput("type", "Select Show Type:", choices = c("All", unique(netflix$type)), selected = "All"),
      selectInput("hist_variable", "Select Histogram Variable:", 
                  choices = c("IMDb Score" = "imdb_score", "Runtime" = "runtime"), 
                  selected = "imdb_score"),
      
      sliderInput("imdb_score", "IMDb Score Range:", 
                  min = min(netflix$imdb_score, na.rm = TRUE),
                  max = max(netflix$imdb_score, na.rm = TRUE), 
                  value = range(netflix$imdb_score, na.rm = TRUE)),
      
      textInput("search", "Search Title:", "")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Overview",
                 fluidRow(
                   valueBoxOutput("totalTitles"),
                   valueBoxOutput("avgImdb"),
                   valueBoxOutput("avgRuntime")
                 ),
                 plotOutput("contentDistribution")
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
  
  output$totalTitles <- renderValueBox({ 
    valueBox(nrow(filtered_data()), "Total Titles", color = "blue") 
  })
  
  output$avgImdb <- renderValueBox({ 
    valueBox(round(mean(filtered_data()$imdb_score, na.rm = TRUE), 2), "Avg IMDb Score", color = "green") 
  })
  
  output$avgRuntime <- renderValueBox({ 
    valueBox(round(mean(filtered_data()$runtime, na.rm = TRUE), 2), "Avg Runtime (mins)", color = "purple") 
  })
  
  output$contentDistribution <- renderPlot({
    data <- filtered_data()
    
    # Check if data is empty
    if (nrow(data) == 0) {
      return(NULL)  
    }
    
    type_counts <- data %>%
      count(type) %>%
      arrange(desc(n))  
    
    ggplot(type_counts, aes(x = type, y = n, fill = type)) +
      geom_bar(stat = "identity", width = 0.6) +  
      
      geom_text(aes(label = n), vjust = -0.5, size = 5, fontface = "bold") +
      
      scale_fill_manual(
        name = "Content Type",  
        values = c("MOVIE" = "blue", "SHOW" = "red"),
        labels = c("Movie", "Show")  
      ) +
      
      labs(
        title = "Content Distribution by Type",
        x = "Type",
        y = "Count"
      ) +
      
      theme_minimal() +
      theme(legend.position = "top") 
  })
  
    
  
  output$histogram <- renderPlot({
    data <- filtered_data()
    
    bin_width <- ifelse(input$hist_variable == "imdb_score", 0.5, 10)
    
    avg_imdb <- round(mean(data$imdb_score, na.rm = TRUE), 2)
    median_runtime <- median(data$runtime, na.rm = TRUE)
    
    annotation_text <- if (input$hist_variable == "imdb_score") {
      paste("Avg IMDb Score:", avg_imdb)
    } else {
      paste("Median Runtime:", median_runtime, "mins")
    }
    
    annotation_x <- if (input$hist_variable == "imdb_score") avg_imdb else median_runtime
    
    ggplot(data, aes_string(x = input$hist_variable, fill = "type")) +
      geom_histogram(binwidth = bin_width, color = "black", alpha = 0.7, position = "identity") +
      geom_density(aes(y = ..count.. * bin_width / 5, color = "type"), alpha = 0.5) +
      
      scale_fill_manual(
        name = "Type",  
        values = c("MOVIE" = "blue", "SHOW" = "red"),
        labels = c("Movie", "Shows")
      ) +
      
      scale_color_manual(
        name = "Type", 
        values = c("MOVIE" = "blue", "SHOW" = "red"),
        labels = c("Movie", "Shows")
      ) +
      
      labs(
        title = paste("Distribution of", ifelse(input$hist_variable == "imdb_score", "IMDb Scores", "Runtime (Minutes)")), 
        x = ifelse(input$hist_variable == "imdb_score", "IMDb Score", "Runtime (Minutes)"), 
        y = "Count"
      ) +
      
      theme_minimal() +
      
      annotate("text", x = annotation_x, y = max(table(data[[input$hist_variable]])) * 0.8, 
               label = annotation_text, color = "white", size = 5, fontface = "bold") +
      
      geom_vline(xintercept = annotation_x, linetype = "dashed", color = "white", linewidth = 1)
  })
  
  output$dataTable <- renderDT({
    datatable(filtered_data(), options = list(pageLength = 10, scrollX = TRUE, searching = FALSE))
  })
}

shinyApp(ui = ui, server = server)



