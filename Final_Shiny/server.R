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
source("R/rank_function.R")
source("R/summ_stat_first.R")
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$title <- renderText ({
    paste("Fatal Car Crashes for Ages", input$ages, "in", input$year)
  })
  
  output$mapPlot <- renderPlot({
    getMap(input$year, input$ages)
  })
  
  output$bargraph <- renderPlot({
    make_bar_graph(eval(parse(text = paste0("CrashData", input$years))), input$states)
  })
  
  output$line_chart <- renderPlot({
    over_time_func(input$selected_state, input$selected_ageGroup, FatalCrashData)
  })
  
  output$summ_stat_1 <- renderText({
    d <- eval(parse(text = paste0("CrashData", input$year_summ_1)))
    first_summ_stat(input$max_min_radio, input$sel_age_summ, input$year_summ_1, d)
  })
  
  output$ranks <- renderTable({
    makeRanks(input$yr, input$st)
  })
  
})
