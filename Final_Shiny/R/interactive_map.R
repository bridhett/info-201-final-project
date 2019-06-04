library(ggplot2)
library(plotly)
library(dplyr)
library(openintro)

source("R/format_data.R")

interactiveMap <- function(year) {
  
  data <- eval(parse(text=paste0("data_", year)))
  
  data <- data%>%
    filter(state != "National", state != "Puerto Rico")
  
  data$code <- state2abbr(data$state)
  data$total_killed <- gsub(",", "", data$total_killed)
  
  
  # specify some map projection/options
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = 'white'
  )
  
  vals <- unique(scales::rescale(c(volcano)))
  o <- order(vals, decreasing = FALSE)
  cols <- scales::col_numeric(c("light green", "#dd4945"), domain = NULL)(vals)
  colz <- setNames(data.frame(vals[o], cols[o]), NULL)
  
  plot_geo(data, locationmode = 'USA-states') %>%
    add_trace(
      hovertext = ~state, z = ~total_killed, locations = ~code,
      colorscale = colz
    ) %>%
    layout(
      title = paste(year, "US Total Killed by State"),
      geo = g
    )
}