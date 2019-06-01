#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
source("R/bar_graph_function.R")
source("R/over_time_function.R")
source("R/map_function.R")
source("R/format_data.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$mapPlot <- renderPlot({
    getMap(input$year, input$ages)
    
  })
  
  output$line_chart <- renderPlot({
    over_time_func(input$selected_state, input$selected_ageGroup, FatalCrashData)
    
  })
  
})
