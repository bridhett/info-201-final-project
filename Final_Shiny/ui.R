#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(selectInput(inputId = "selected_state", 
                label = "States", 
                choices = sort(FatalCrashData$state), 
                multiple = FALSE, selected = "AL"), 
                
                selectInput(inputId = "selected_ageGroup",
                            label = "Age Groups",
                            choices = c("<5", "5-9", "10-15", "16-20", "21-24", "25-34", 
                                        "35-44", "45-54", "55-64", "65-74", ">74", "unknown", 
                                        "total_killed"),
                            multiple = FALSE)),
    mainPanel(plotOutput("line_chart")))
  
  
))
