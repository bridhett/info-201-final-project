## year and age group = gradient map
library("dplyr")
library("ggplot2")
library("sf")

source("R/format_data.R")

getMap <- function(year, age_group) {
  
  data <- eval(parse(text=paste0("data_", year)))
  
  cols <- c("state", age_group,"unknown")
  data <- data[grepl(paste(cols, collapse="|"), names(data))]
  
  data$state <- tolower(data$state)
  
  data$state <- gsub("dist", "district", data$state)
  
  data <- data[!grepl("national", data$state), ]
  
  hi_ak <- c("hawaii", "alaska")
  rogue_data <- data[grepl(paste(hi_ak, collapse="|"), data$state), ]  
  
  map_data <- map_data("state") %>%
    rename(state = region) %>%
    select(-subregion)
  
  rogue_states <- map_data("world") %>% 
    filter(region == "USA") %>%
    rename(state = subregion) %>% 
    filter(state == "Hawaii" | state == "Alaska") %>%
    select(-region)
  
  rogue_states$state <- tolower(rogue_states$state)
  
  rogue_joined <- left_join(rogue_data, rogue_states, by = "state")
  
  joined <- left_join(data, map_data, by = "state")
  
  remove_axes <- theme(
    axis.text = element_blank(),
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    panel.border = element_blank(),
    panel.grid = element_blank(),
    axis.title = element_blank()
  )

  fatalities <- joined[, age_group]
  fatalities <- as.numeric(fatalities)

  fatality <- rogue_joined[, age_group]
  fatality <- as.numeric(fatality)
  # min <- fatalities == min(fatalities)
  # min <- joined[min,]
  # 
  # max <- fatalities == max(fatalities)
  # max <- joined[max,]
  
  g1 <- ggplot(joined, aes(x = long, y = lat, group = group)) +
    geom_polygon(aes(fill = fatalities)) +
    scale_fill_gradient(low= "yellow", high = "maroon", trans = "log10") +
    ggtitle(paste("Fatal Car Crashes for Ages", age_group, "in", year)) +
    theme(text=element_text(size=16,  family="serif"),
          plot.title = element_text(hjust = 0.5)) +
    labs(fill = "Fatalities") +
    coord_map() +
    remove_axes
  
  g2 <- ggplot(rogue_joined, aes(x = long, y = lat, group = group)) +
    geom_polygon(aes(fill = fatality)) +
    scale_fill_gradient(low= "yellow", high = "maroon", trans = "log10") +
    ggtitle("AK and HI") +
    theme(rect = element_rect(fill = "transparent"),
         plot.background = element_rect(fill = "transparent", color = NA),
         text=element_text(size=14,  family="serif"),
         plot.title = element_text(hjust = 0.5)) +
    labs(fill = "Fatalities") +
    coord_fixed(xlim = c(-180, -125), ylim = c(20, 75)) +
    remove_axes
  
  vp <- viewport(width = 0.3, height = 0.4, x = 0.2, y = 0.2)
  
  print(g1)
  print(g2, vp = vp)
}  

getMap(2011, "21-24")
