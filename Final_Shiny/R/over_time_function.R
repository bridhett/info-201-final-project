library(easycsv)
library(ggplot2)
library(reshape2)
library(dplyr)
library(tidyr)

loadcsv_multi(directory = "data")

change_rownames <- function(file_name, year) {
  names(file_name) <- c("state", paste0("<5.", year), paste0("5-9.", year), 
                        paste0("10-15.", year), paste0("16-20.", year), paste0("21-24.", year), 
                        paste0("25-34.", year), paste0("35-44.", year), paste0("45-54.", year), 
                        paste0("55-64.", year), paste0("65-74.", year), paste0(">74.", year), 
                        paste0("unknown.", year), paste0("total_killed.", year))
  
  return(file_name)
}

FatalCrashData2010 <- change_rownames(FatalCrashData2010, "2010")
FatalCrashData2011 <- change_rownames(FatalCrashData2011, "2011")
FatalCrashData2012 <- change_rownames(FatalCrashData2012, "2012")
FatalCrashData2013 <- change_rownames(FatalCrashData2013, "2013")
FatalCrashData2014 <- change_rownames(FatalCrashData2014, "2014")
FatalCrashData2015 <- change_rownames(FatalCrashData2015, "2015")
FatalCrashData2016 <- change_rownames(FatalCrashData2016, "2016")
FatalCrashData2017 <- change_rownames(FatalCrashData2017, "2017")


FatalCrashData <- Reduce(function(x,y) merge(x,y,by="state",all=TRUE) ,list(FatalCrashData2010,FatalCrashData2011,FatalCrashData2012,FatalCrashData2013,
                                                                            FatalCrashData2014,FatalCrashData2015,FatalCrashData2016,FatalCrashData2017))

over_time_func <- function(state_name, age_group, input) {
  state_year_data <- input %>%
    filter(state == state_name) %>%
    select(state, contains(age_group))

  state_year_data <- state_year_data %>% 
    gather(key="year", value = "fatalities", -state) %>%
    mutate(year = sub("^[^.]*", "", year)) %>%
    mutate(year = sub("\\.", "", year))
  
  ggplot(state_year_data, aes(x = year, y = fatalities)) + 
    geom_line(group = 1, color =  "#e57070") + 
    geom_point(color = "light green") +
    labs(x = "Year", y = "Fatalities") 
}

over_time_func("Florida", "unknown", FatalCrashData)
