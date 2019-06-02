library(dplyr)

dooby_2010 <- read.csv("data/FatalCrashData2010.csv", stringsAsFactors = FALSE)

names(dooby_2010) <- c("state", "<5", "5-9", "10-15", "16-20", "21-24", "25-34", 
                      "35-44", "45-54", "55-64", "65-74", ">74", "unknown", 
                      "total_killed")

first_summ_stat <- function(max_min, sel_age_grp, yr, d) {
  d <- d %>%
    filter(state != "National", state != "Puerto Rico") %>%
    select(state, sel_age_grp)
    
  #d <- d[order(-(d[[sel_age_grp]])),]
  if(max_min == "Max") {
    d <- d[d[[sel_age_grp]] == max(d[[sel_age_grp]]),]
    list <- as.vector(d$state)
    paste(paste0(list, collapse = ", "), "had the most deaths in", yr, "with",d[1,2])
  } else {
    d <- d[d[[sel_age_grp]] == min(d[[sel_age_grp]]),]
    list <- as.vector(d$state)
    paste(paste0(list, collapse = ", "), "had the least deaths in", yr, "with",d[1,2])
  }
}

first_summ_stat("Max", "5-9", 2010, dooby_2010)

