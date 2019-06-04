library(dplyr)

source("R/format_data.R")

makeRanks <- function(year, ...) {
  data <- eval(parse(text=paste0("data_", year)))
  
  data$total_killed <- gsub(",", "", data$total_killed)
  data <- data[-c(52:53), ]
  data <- data[order(-as.numeric(data$total_killed)), ] 
  
  states <- if(is.null(c(...))) {
    max <- data[which.max(data$total_killed),]
    } else {
      c(...)
    }
  
  data <- data[data$state %in% states, ]
  
  num_rows <- nrow(data) 
  
  data$rank <- paste0("#", 1:num_rows)
  
  data <- data %>%
    select(rank, state, total_killed) %>%
    rename(Rank = rank,
           State = state,
           "Total Killed" = total_killed)
}