library(jsonlite)
library(httr)
library(dplyr)
library(plotly)

source("apikey_harim.R")

get_graph <- function(start_d, end_d, day_viewed, var_viewed){

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
       "estimated diam min (feet)" = days_observed[[i]]$estimated_diameter$
         feet$estimated_diameter_min,
       "estimated diam max (feet)" = days_observed[[i]]$estimated_diameter$
         feet$estimated_diameter_max,
       "potentially dangerous" = days_observed[[i]]$
         is_potentially_hazardous_asteroid,
       stringsAsFactors = F)
    
    # Gets specific data for the specific asteroid 
   
    
    for (j in 1:length(days_observed[[i]]$close_approach_data)){
      
      asteroids[[i]]$miss_distance[[j]] <- days_observed[[i]]$
        close_approach_data[[j]]$miss_distance$miles
      
      asteroids[[i]]$relative_velocity_mph[[j]] <- days_observed[[i]]$
        close_approach_data[[j]]$relative_velocity$miles_per_hour
      
      asteroids[[i]]$orbiting_body[[j]] <- days_observed[[i]]$
        close_approach_data[[j]]$orbiting_body
                                        
    }
    
    # set list value names to be the date observed
    names(asteroids)[i] <- paste(start_d + i - 1)
    
  }
  
  # start to make plot
  
  plot <- plot_ly(asteroids[[day_viewed]], x = ~miss_distance, #sets x & y data
                  y = ~asteroids[[day_viewed]][, var_viewed], 
                  type = "scatter", 
                  mode = "markers", 
                  text = ~paste("<br>Name: ", name, # Sets the hover text for 
                                "<br>ID: ", id,     # each marker
                                "<br>Absolute Magnitude: ", 
                                absolute.magnitude, 
                                "<br>Estimated Max Diameter (Feet): ",
                                round(estimated.diam.max..feet., 2),
                                "<br>Estimated Min Diameter (Feet): ",
                                round(estimated.diam.max..feet., 2),
                                "<br>Potentially Dangerous: ",
                                potentially.dangerous,
                                "<br>Orbiting Body: ",
                                orbiting_body),
                  color = ~potentially.dangerous, colors = c("green", "red"),
                  xaxis = list(autotick = FALSE),
                  yaxis = list(autotick = FALSE)) %>% 
    layout(xaxis = list(title = "Miss Distance (miles)"),
           yaxis = list(title = paste(var_viewed)))
  
  
}  
