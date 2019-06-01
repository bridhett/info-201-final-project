#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
source('R/bar_graph_function.R')
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(selectInput(inputId = "states", 
                label = "Choosing a state:", 
                choices = CrashData2010$state), 
                
                sliderInput(inputId = "year",
                            label = "Choosing a year:",
                            min = 2010,
                            max = 2017,
                            value = 1,
                            sep = "")),
    mainPanel(plotOutput("bargraph")))
  
  
))
