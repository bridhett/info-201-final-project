library(easycsv)
library(ggplot2)
library(reshape2)
library(dplyr)

## Contains the function to make a bar graph with (x = ages, y = number of death).

loadcsv_multi(directory = "data")

change_rownames <- function(file_name) {
  names(file_name) <- c("state", "<5", "5-9", "10-15", "16-20", "21-24", "25-34", "35-44",
                                 "45-54", "55-64", "65-74", ">74", "unknown", "total_killed")
  
  return(file_name)
}

FatalCrashData2010 <- change_rownames(FatalCrashData2010)
FatalCrashData2011 <- change_rownames(FatalCrashData2011)
FatalCrashData2012 <- change_rownames(FatalCrashData2012)
FatalCrashData2013 <- change_rownames(FatalCrashData2013)
FatalCrashData2014 <- change_rownames(FatalCrashData2014)
FatalCrashData2015 <- change_rownames(FatalCrashData2015)
FatalCrashData2016 <- change_rownames(FatalCrashData2016)
FatalCrashData2017 <- change_rownames(FatalCrashData2017)

## data -> choosing a table from above
## state_name -> enter a string of state name
make_bar_graph <- function(data, state_name) {
  melted_data <- melt(data, id.vars = "state", measure.vars = c("<5", "5-9", "10-15", "16-20", "21-24", "25-34", "35-44",
                                                                                   "45-54", "55-64", "65-74", ">74", "unknown"))
  melted_data <- filter(melted_data, state == state_name)

  melted_data$value <- as.numeric(melted_data$value)

  cols <- c("blue", "red")[(melted_data$value > max(melted_data$value)/2) + 1] 
  
  barplot(melted_data$value, main=paste0("Number of death based on ages in ", state_name),
        names.arg=melted_data$variable, cex.names = 0.7, yaxp=c(0, round(max(melted_data$value), -1), 5),
        col = cols)
  
}

## plot <- make_bar_graph(FatalCrashData2011, "Georgia")