data <- read.csv("data/FatalCrashData2011.csv")

names(data) <- c("state", "<5", "5-9", "10-15", "16-20", "21-24", "25-34", "35-44", 
                 "45-54", "55-64", "65-74", ">74", "unknown", "total_killed") 
data$10-15

## year and age group = gradient map

getData <- function(csv_file, give_name) {
  give_name  <- read.csv(csv_file)
  print(given_name)
  names(given_name) <- c("state", "<5", "5-9", "10-15", "16-20", "21-24", "25-34", 
                       "35-44", "45-54", "55-64", "65-74", ">74", "unknown", 
                       "total_killed") 
}

getData("data/FatalCrashData2011.csv", "data_2011")
