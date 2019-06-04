## year and age group = gradient map
library("dplyr")
library("ggplot2")
library("fiftystater")
library("tmap")
library("tmaptools")
library("leaflet")

source("R/format_data.R")

getMap <- function(year, age_group) {
  
  data <- eval(parse(text=paste0("data_", year)))
  
  cols <- c("state", age_group,"unknown")
  data <- data[grepl(paste(cols, collapse="|"), names(data))]
  
  data$state <- tolower(data$state)
  
  data$state <- gsub("dist", "district", data$state)
  
  data <- data %>%
    filter(state != "national",
           state != "puerto rico")
  
  fatalities <- data[, age_group]
  fatalities <- as.numeric(fatalities)
  
  min <- min(fatalities)
  
  max <- max(fatalities)
  
ggplot(data, aes(map_id = state)) + 
    # map points to the fifty_states shape data
    geom_map(aes(fill = fatalities), map = fifty_states) + 
    expand_limits(x = fifty_states$long, y = fifty_states$lat) +
    scale_fill_gradient(low= "light green", high = "#e57070", breaks = 
                          seq(min, max, floor((max-min)/4))) +
    theme(text=element_text(size=16,  family="serif"),
          legend.position = "right", 
          panel.background = element_blank()) +
    labs(fill = "Fatalities", x = "", y = "") +
    coord_map() +
    scale_x_continuous(breaks = NULL) + 
    scale_y_continuous(breaks = NULL) 
}  