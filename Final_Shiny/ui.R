#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
source("R/format_data.R")
source("R/over_time_function.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("year",
                  "Choose a Year:",
                  min = 2010,
                  max = 2017,
                  value = 1,
                  sep = ""),
      
      selectInput("ages", "Choose an Age Group:",
                  choices = c("<5", "5-9", "10-15", "16-20", "21-24", "25-34", 
                              "35-44", "45-54", "55-64", "65-74", ">74", 
                              "unknown")),
      
      selectInput(inputId = "selected_state", 
                label = "States", 
                choices = sort(FatalCrashData$state), 
                multiple = FALSE, selected = "AL"), 
                
                selectInput(inputId = "selected_ageGroup",
                            label = "Age Groups",
                            choices = c("<5", "5-9", "10-15", "16-20", "21-24", "25-34", 
                                        "35-44", "45-54", "55-64", "65-74", ">74", "unknown", 
                                        "total_killed"),
                            multiple = FALSE)
                ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Mapped Data", plotOutput("mapPlot")),
        tabPanel("Bar Graph", plotOutput("bargraph")),
        tabPanel("Line Chart", h3("         "), plotOutput("line_chart"))
      )
    )
  )
))
