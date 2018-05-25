library(jsonlite)
library(httr)
library(dplyr)
library(plotly)

source("apikey_harim.R")

get_graph <- function(start_d, end_d){

  start_d <- "2018-05-20"
  end_d <- "2018-05-25"
  
  # test dates
  start_d <- as.Date(start_d, format="%Y-%m-%d")
  end_d <- as.Date(end_d, format="%Y-%m-%d")
  
  # number of data sets from dates requested
  days <- as.numeric(end_d - start_d) + 1
  
  # get data from api
  url <- "https://api.nasa.gov/neo/rest/v1/feed"
  query_params <- list(start_date = start_d,
                       end_date = end_d,
                       api_key = api_key_nasa)
  
  response <- GET(url, query = query_params)
  
  response_content <- content(response, "text")
  data <- fromJSON(response_content)
  
  # length of asteroids list will be equal to days
  days_observed <- data$near_earth_objects
  
  asteroids <- list()
  
  for (i in 1:days){
    
    # Get number of asteroids
    number_of_asteroids <- length(days_observed[[i]]$name)
    
    # make a list of asteroids with all the dates requested, inside of each date
    # is a data frame full of the asteroids observed that day
    asteroids[[i]] <- data.frame(
       "name" = days_observed[[i]]$name,
       "id" = days_observed[[i]]$neo_reference_id,
       "url" = days_observed[[i]]$nasa_jpl_url,
       "absolute magnitude" = days_observed[[i]]$absolute_magnitude_h,
       "estimated diam min (feet)" = days_observed[[i]]$estimated_diameter$feet$estimated_diameter_min,
       "estimated diam max (feet)" = days_observed[[i]]$estimated_diameter$feet$estimated_diameter_max,
       "potentially dangerous" = days_observed[[i]]$is_potentially_hazardous_asteroid,
       stringsAsFactors = F)
    
    # Gets specific data for the specific asteroid 
    for (j in 1:number_of_asteroids){
      
      asteroids[[i]] <- asteroids[[i]] %>% 
        mutate("relative velocity" = days_observed[[i]]$close_approach_data[[j]]$relative_velocity[[3]],
               "miss distance" = days_observed[[i]]$close_approach_data[[j]]$miss_distance[[4]],
               "orbitting" = days_observed[[i]]$close_approach_data[[j]]$orbiting_body)

    }
    
    
    # set list value names to be the date observed
    names(asteroids)[i] <- paste(start_d + i - 1)
    
  }
  
  steps <- list()
  
  plot <- plot_ly()
  
  for (i in 1:length(asteroids)){
    
    plot <- add_trace(plot, x = asteroids[[i]]$`miss distance`,
                      y = asteroids[[i]]$`relative velocity`,
                      type = "scatter", mode = "markers")
    
  }
  
}  
