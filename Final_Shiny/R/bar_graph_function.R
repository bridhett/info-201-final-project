library(easycsv)
library(ggplot2)
library(reshape2)

## Contains the function to make a bar graph with (x = ages, y = number of death).

loadcsv_multi(directory = "data")

rename_rows <- function(file_name) {
  names(file_name) <- c("state", "<5", "5-9", "10-15", "16-20", "21-24", "25-34", "35-44",
                                 "45-54", "55-64", "65-74", ">74", "unknown", "total_killed")
  
  return(file_name)
}

CrashData2010 <- rename_rows(FatalCrashData2010)
CrashData2011 <- rename_rows(FatalCrashData2011)
CrashData2012 <- rename_rows(FatalCrashData2012)
CrashData2013 <- rename_rows(FatalCrashData2013)
CrashData2014 <- rename_rows(FatalCrashData2014)
CrashData2015 <- rename_rows(FatalCrashData2015)
CrashData2016 <- rename_rows(FatalCrashData2016)
CrashData2017 <- rename_rows(FatalCrashData2017)

## data -> choosing a table from above
## state_name -> enter a string of state name
make_bar_graph <- function(data, state_name) {
  melted_data <- melt(data, id.vars = "state", measure.vars = c("<5", "5-9", "10-15", "16-20", "21-24", "25-34", "35-44",
                                                                                   "45-54", "55-64", "65-74", ">74", "unknown"))
  melted_data <- filter(melted_data, state == state_name)
  
  melted_data$value <- as.numeric(melted_data$value)

  cols <- c("green", "red")[(melted_data$value > max(melted_data$value)/2) + 1] 
  
  barplot(melted_data$value, main=paste0("Number of death based on ages in ", state_name),
        names.arg=melted_data$variable, cex.names = 0.7, yaxp=c(0, round(max(melted_data$value), -1), 5),
        col = cols)
  
}


##plot <- make_bar_graph(CrashData2011, "Georgia")
