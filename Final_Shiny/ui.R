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
source("R/bar_graph_function.R")
# Define UI for application that draws a histogram
shinyUI(navbarPage("Fatal Car Crashes in the USA",
                   tabPanel("Map",
                            fluidRow(includeCSS("style.css"),
                                     sidebarPanel(
                                             h1("Nation Wide Fatal Car Crashes"),
                                             p("The map "),
                                             hr(),
                              sliderInput("year",
                                          "Choose a Year:",
                                          min = 2010,
                                          max = 2017,
                                          value = 1,
                                          sep = ""),
                              
                              selectInput("ages", "Choose an Age Group:",
                                          choices = c("<5", "5-9", "10-15", "16-20", "21-24", "25-34", 
                                                      "35-44", "45-54", "55-64", "65-74", ">74", 
                                                      "unknown"))),
                              mainPanel(textOutput("title"),
                                        plotOutput("mapPlot")))
                   ),
                   
                   tabPanel("Bar Graph",
                            fluidRow(column(12,

                                          h1("Fatal Car Crashes Per State"),
                                          p("A bar graph showing number of death in different years and states based on age groups."))),
                            hr(),
                            fluidRow(sidebarPanel(
                              sliderInput("years",
                                          "Choose a Year:",
                                          min = 2010,
                                          max = 2017,
                                          value = 1,
                                          sep = ""),
                              
                              selectInput(inputId = "states", 
                                          label = "Choose a state:", 
                                          choices = (CrashData2010[-c(52:53), ]$state))),
                              mainPanel(plotOutput("bargraph")))
                   ),
                   
                   tabPanel("Line Graph",
                            fluidRow(sidebarPanel(
                              selectInput(inputId = "selected_state", 
                                          label = "States", 
                                          choices = sort(FatalCrashData$state), 
                                          multiple = FALSE, selected = "AL"), 
                              
                              selectInput(inputId = "selected_ageGroup",
                                          label = "Age Groups",
                                          choices = c("<5", "5-9", "10-15", "16-20", "21-24", "25-34", 
                                                      "35-44", "45-54", "55-64", "65-74", ">74", "unknown", 
                                                      "total_killed"),
                                          multiple = FALSE)),
                              mainPanel(h3("         "), plotOutput("line_chart")))
                   ),
                   
                   navbarMenu("Summary Stats",
                              tabPanel("Most Deaths",
                                       fluidRow(sidebarPanel(
                                         selectInput(inputId = "sel_age_summ",
                                                     label = "Age Group",
                                                     choices = c("<5", "5-9", "10-15", "16-20", "21-24", "25-34", 
                                                                 "35-44", "45-54", "55-64", "65-74", ">74", "unknown", 
                                                                 "total_killed"),
                                                     multiple = FALSE),
                                         radioButtons(inputId = "max_min_radio",
                                                      label = "Select",
                                                      choices = list("Max", "Min"),
                                                      selected = "Max"),
                                         sliderInput(inputId = "year_summ_1",
                                                     label = "Choose a year:",
                                                     min = 2010,
                                                     max = 2017,
                                                     value = 2010,
                                                     sep = "")
                                       ),
                                       mainPanel(h1("Max and Min fatalities based off of age and year"),h3(textOutput("summ_stat_1"))))),
                              
                     tabPanel("State Rank",
                              fluidRow(column(12,
                                              h1("State Rankings Per Year"),
                                              p("ed on age groups."))),
                              hr(),
                              fluidRow(sidebarPanel(
                                sliderInput("yr",
                                            "Choose a Year:",
                                            min = 2010,
                                            max = 2017,
                                            value = 1,
                                            sep = ""),
                                
                                selectInput("st", "Select States:",
                                            multiple = TRUE,
                                            data_2010[-c(52:53), ]$state)),
                                mainPanel(tableOutput("ranks")))
                   ))
))

