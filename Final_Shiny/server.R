library(shiny)
source("R/bar_graph_function.R")
source("R/over_time_function.R")
source("R/map_function.R")
source("R/format_data.R")
source("R/rank_function.R")
source("R/summ_stat_first.R")
source("R/interactive_map.R")

shinyServer(function(input, output) {
  
  output$plotly <- renderPlotly ({
    interactiveMap(input$y)
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
  
  output$states <- renderPlot ({
    d <- eval(parse(text = paste0("CrashData", input$year_summ_1)))
    getStates(first_summ_stat(input$max_min_radio, input$sel_age_summ, input$year_summ_1, d))
  })
  
  output$ranks <- renderTable({
    makeRanks(input$yr, input$st)
  })
  
})
