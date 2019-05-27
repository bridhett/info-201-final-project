library(easycsv)
library(ggplot2)

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

#ggplot(FatalCrashData2010, aes(x = c("<5", "5-9", "10-15"), y = "state")) + geom_line() + geom_point()


# 
# state_year_comparisons <- function(state_name) {
#   
# }


