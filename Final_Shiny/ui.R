#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
source("R/format_data.R")
source("R/over_time_function.R")
source("R/bar_graph_function.R")
# Define UI for application that draws a histogram
shinyUI(navbarPage("Fatal Car Crashes in the USA",
         tabPanel("Nation Wide",
                  fluidRow(includeCSS("style.css"),
                           column(12,
                                  h1("Nation Wide Fatal Car Crashes")),
                           column(12,
                                  p("To utilize the first map plot, first choose the year you are interested in. 
                                  Then you can hover over a state with your mouse to find the total amount of kills 
                                  in that year. In the second map plot, choose the year and age group and then you 
                                  will be able to see the U.S. states color coded by how many fatalities they had 
                                  for that age group in that year. In both maps, Green indicates a low fatality 
                                  number and a fading into red indicates higher fatalities. This can be important 
                                  to use if you want to see the most dangerous places for a specific age group."))),
                  hr(),
                  
                  fluidRow(sidebarPanel(
                    sliderInput("y",
                                "Choose a Year:",
                                min = 2010,
                                max = 2017,
                                value = 1,
                                sep = "")),
                    mainPanel(h2("Total Killed Per State"),
                              plotlyOutput("plotly"))),
                  hr(),
  
                  fluidRow(sidebarPanel(
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
                    mainPanel(h2("Fatalities Per State by Age Group and Year"),
                              plotOutput("mapPlot")))
         ),
         
         tabPanel("State Wide",
                  fluidRow(column(12,
                                h1("Fatal Car Crashes Per State"),
                                p("To utilize this bar graph, first choose the year you are interested in and 
                                the state. In the bar graph you will see the number of car crash deaths in 
                                the state for each age group of the year. A red colored bar indicates that 
                                the number is above the national average while the green colored bar 
                                indicates that it's below average. This can be important to use to find out 
                                  which age groups suffer the most deaths from car crashes."))),
                  hr(),
                  fluidRow(sidebarPanel(
                    sliderInput("years",
                                "Choose a Year:",
                                min = 2010,
                                max = 2017,
                                value = 1,
                                sep = ""),
                    
                    selectInput(inputId = "states", 
                                label = "Choose a State:", 
                                choices = (CrashData2010[-c(52:53), ]$state))),
                    mainPanel(h2("Number of Deaths Per Age Group"),
                               plotOutput("bargraph")))
         ),
         
         tabPanel("Over Time",
                  fluidRow(column(12,
                                   h1("Fatal Car Crashes Over time"),
                                   p("To utitlize this line graph, first choose the state you are interested in 
                                   and the age group. In the line graph, you will see how the number of 
                                   fatalities progress throughout the years. This can be important to use to 
                                   find out whether a state's fatality rate is improving or getting worse as 
                                     time goes by for the selected age group."))),
                  hr(),
                  fluidRow(sidebarPanel(
                    selectInput(inputId = "selected_state", 
                                label = "Choose a State:", 
                                choices = sort(FatalCrashData$state), 
                                multiple = FALSE, selected = "AL"), 
                    
                    selectInput(inputId = "selected_ageGroup",
                                label = "Choose an Age Group:",
                                choices = c("<5", "5-9", "10-15", "16-20", "21-24", "25-34", 
                                            "35-44", "45-54", "55-64", "65-74", ">74", "unknown", 
                                            "total_killed"),
                                multiple = FALSE)),
                    mainPanel(h2("Fatalities from 2010 to 2017"), 
                              plotOutput("line_chart")))
         ),
         
         navbarMenu("Summary Stats",
                    tabPanel("Case Summary",
                             fluidRow(sidebarPanel(
                               selectInput(inputId = "sel_age_summ",
                                           label = "Choose an Age Group:",
                                           choices = c("<5", "5-9", "10-15", "16-20", "21-24", "25-34", 
                                                       "35-44", "45-54", "55-64", "65-74", ">74", "unknown", 
                                                       "total_killed"),
                                           multiple = FALSE),
                               radioButtons(inputId = "max_min_radio",
                                            label = "",
                                            choices = list("Max", "Min"),
                                            selected = "Max"),
                               sliderInput(inputId = "year_summ_1",
                                           label = "Choose a Year:",
                                           min = 2010,
                                           max = 2017,
                                           value = 2010,
                                           sep = "")
                             ),
                             mainPanel(h2("Max and Min Fatalities Based on Age and Year"),
                                       textOutput("summ_stat_1"),
                                       plotOutput("states"))), 
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
                               mainPanel(h2("State Rankings Per Year"),tableOutput("ranks")))
                             ),
                    
                    tabPanel("Project Conclusion",
                             fluidRow(column(12,
                                            h1("Mission Statement"),
                                            hr(),
                                            p("The data that we are working with are 8 data sets (2010-2017) from the National 
                                              Highway Traffic Safety Administrations (NHTSA). These tell us the number of 
                                              people killed in fatal car crashes based on age group and US state.\n
                                              Our mission for our data that we report is to give insight to people who may be
                                              affected by vehicle laws in their state. We hope that this information plays as a
                                              determining factor on whether residents stay in/move to a certain state or not, 
                                              especially families. Also, we hope that legislators and lawmakers make use of our
                                              data for evidence to improve vehicle laws in their representing area."))))
                             )

))

