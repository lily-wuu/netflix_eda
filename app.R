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
  titlePanel("What is Playing on Netflix?"),
  
  sidebarLayout(
    sidebarPanel(
      tags$div(
        img(src = "data:image/jpeg;base64,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", height = "100px")
      ),      
      selectInput("type", "Select Type of Content:", choices = c("All", unique(netflix$type)), selected = "All"),
      
      sliderInput("imdb_score", "IMDb Score Range:", 
                  min = min(netflix$imdb_score, na.rm = TRUE),
                  max = max(netflix$imdb_score, na.rm = TRUE), 
                  value = range(netflix$imdb_score, na.rm = TRUE)),
      
      selectInput("hist_variable", "Select Histogram Variable:", 
                  choices = c("IMDb Score" = "imdb_score", "Runtime" = "runtime"), 
                  selected = "imdb_score"),
      
      textInput("search", "Search for Movie:", "")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Overview",
                 
                 tags$h3("Overview of Content on Netflix"),
                 tags$p("Welcome! In this app, you can explore key statistics about Netflix content, including the total 
                        count of shows/movies, average IMDb scores, and runtime information.  Feel free to play around with the filters on the left to  find what you are looking for."),

                 fluidRow( # help from ChatGPT
                   valueBoxOutput("totalTitles"),
                   valueBoxOutput("avgImdb"),
                   valueBoxOutput("avgRuntime")
                 ),
                 plotOutput("contentDistribution"),
                 tags$p("* Fun fact:  TV shows tend to be ranked higher than movies.")
        ), 
        
        tabPanel(
          "Visuals",
          
          tags$h3("IMDb Ratings and Runtime Histograms"),
          tags$p("This dynamic histogram can help you see how IMDb ratings and runtimes 
                        are distributed across media types. You can switch between 'IMDb Score' and 'Runtime' 
                        using the filter on the left. Use the first filter in the sidebar to look at movies and shows seperately. For the IMDb histogram, the dashed line marks the average score line, and for the Runtime, the dashed line indicates the median runtime. "),
          
          plotOutput("histogram")),
        
        tabPanel(
          "Library",
          
          tags$h3("Exploring Individual Works"),
          tags$p("The table below allows you to browse Netflix's content library in detail. 
                        Use the search option in the sidebar if you are looking to find detailed data for a specific movie/show."),
          
          DTOutput("dataTable")
          
          ),
        
        tabPanel(
          "References",
          
          tags$h3("Data Source and Misc"),
          tags$p(
            "The data for this project comes from the ",
            tags$a(href = "https://github.com/amirtds/kaggle-netflix-tv-shows-and-movies/tree/main", 
                   "Netflix TV Shows and Movies Dataset on GitHub"),
            "."
          ),
          
          tags$h4(
            "Objective"
          ),
          tags$p(
            "I created this app to practice the skills I learned in my data visualization class (STAT 302). I also love anything entertainment, so I wanted to create something to explore the offerings on Netflix. I was most interested in exploring the \"better\" films, so I focused exploration related to the IMDb scores."
          ),
          
          tags$h4(
            "Additional Information"
          ),
          tags$p(
            "The features of this app are designed to help users find highly-rated content on Netflix efficiently. The overview tab helps the user get a general understanding of the offerings available. Users can then filter by the IMDb scores and look more closely at the broken down IMDb scores and runtimes by content type in the \"Visuals\" tab with the histogram, helping them determine if the rating range and runtime is what they are looking for. It gives them access to easily see the availability of highly-rated content before having to read through a detailed list. Once they figure that out, they can move to the library, where they can search for specific titles and find detailed information regarding all the filtered works."
             ),
          
          
          tags$h4(
            "Use of Generative AI"
          ),
          tags$p(
            "Generative AI was used as an aid to fix coding errors and when searching for specific features in Shiny. Specific code chunks pulled from ChatGPT has been commented out in the R script."
          )
        )
      )
    )
  )
)

server <- function(input, output) {
  
  filtered_data <- reactive({
    data <- netflix |> select(title, type, description, imdb_score, runtime, release_year)
    if (input$type != "All") {
      data <- data |> filter(type == input$type)
    }
    data <- data |> filter(imdb_score >= input$imdb_score[1], imdb_score <= input$imdb_score[2])
    if (input$search != "") {
      data <- data |> filter(str_detect(title, regex(input$search, ignore_case = TRUE))) # help from Chat GPT
    }
    return(data)
  })
  
  output$totalTitles <- renderValueBox({ 
    valueBox(nrow(filtered_data()), "Total Works", color = "blue") 
  })
  
  output$avgImdb <- renderValueBox({ 
    valueBox(round(mean(filtered_data()$imdb_score, na.rm = TRUE), 2), "Avg IMDb Score", color = "green") 
  })
  
  output$avgRuntime <- renderValueBox({ 
    valueBox(round(mean(filtered_data()$runtime, na.rm = TRUE), 2), "Avg Runtime (mins)", color = "purple") 
  })
  
  output$contentDistribution <- renderPlot({
    data <- filtered_data()
    
    type_counts <- data |>
      count(type) |>
      arrange(desc(n))  
    
    ggplot(type_counts, aes(x = type, y = n, fill = type)) +
      geom_bar(stat = "identity", width = 0.6, alpha = 0.2, color = "black") +  
      geom_text(aes(label = n), vjust = 1.5, size = 5, fontface = "bold") +
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
    
    annotation_x <- if (input$hist_variable == "imdb_score") avg_imdb else median_runtime # help from chatgpt
    
    ggplot(data, aes_string(x = input$hist_variable, fill = "type")) +
      geom_histogram(binwidth = bin_width, color = "black", alpha = 0.2, position = "identity") +
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
      geom_vline(xintercept = annotation_x, linetype = "dashed", color = "white", linewidth = 1)+
      annotate("text", x = annotation_x, y = max(table(data[[input$hist_variable]])) * 0.8, 
             label = annotation_text, color = "black", size = 5, fontface = "bold") 
  })
  
  output$dataTable <- renderDT({
    datatable(filtered_data(), options = list(pageLength = 10, scrollX = TRUE, searching = FALSE)) 
  })
}

shinyApp(ui = ui, server = server)



