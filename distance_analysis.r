library(dplyr)
library(ggplot2)
library(plotly)
library(jsonlite)
library(httr)
library(RColorBrewer)



source("apikey_raf.r")

# Sets up the parameters and queries for the API and
# GET request
base_uri <- "https://api.nasa.gov/neo/rest/v1/neo/"
resource <- "browse"
query_params <- list(api_key = apikey)
endpoint <- paste0(base_uri, resource)


# Performs the GET request to retrieve the information from
# the NASA API
response <- GET(endpoint, query = query_params)
body <- content(response, "text")
results <- fromJSON(body)


# All the known data about the closest object to Earth
near_earth_objects <- results$near_earth_objects
objects <- list()

# Creates a separated dataframe for each asteroid to make
# reading it much easier

for (i in 1:nrow(near_earth_objects)) {
  objects[[i]] <- data.frame(
    "name" = near_earth_objects$name[[i]],
    "Absolute Magnitude" = near_earth_objects$absolute_magnitude_h[[i]],
    "Minimum Estimated Diameter (km)" =
      near_earth_objects$estimated_diameter$kilometers$estimated_diameter_min[[i]],
    "Minimum Estimated Diameter (m)" =
      near_earth_objects$estimated_diameter$meters$estimated_diameter_min[[i]],
    "Minimum Estimated Diameter (mi)" =
      near_earth_objects$estimated_diameter$miles$estimated_diameter_min[[i]],
    "Maximum Estimated Diameter (km)" =
      near_earth_objects$estimated_diameter$kilometers$estimated_diameter_max[[i]],
    "Maximum Estimated Diameter (m)" =
      near_earth_objects$estimated_diameter$meters$estimated_diameter_max[[i]],
    "Maximum Estimated Diameter (mi)" =
      near_earth_objects$estimated_diameter$miles$estimated_diameter_max[[i]],
    "Dangerous?" = near_earth_objects$is_potentially_hazardous_asteroid[[i]],
    stringsAsFactors = FALSE
  )
}

# Extracts the dataframes from the list in close_approach_data
# Empty list for the dataframes to be stored in
objects2 <- list()
approach <- near_earth_objects %>% select(name, close_approach_data)

# Extracts the Miss Distance information from the original dataframe
# and puts it into its own list for easier access
# and adds an empty dataframe into the list if there is no data found
# in order to maintain the same amount of rows
for (i in 1:nrow(near_earth_objects)) {
  
  # Number of different information for a single asteroid
  last <- length(approach$close_approach_data[[i]][["miss_distance"]])
  
  if (last > 0) {
    for (j in 1:last) {
      objects2[[i]] <- data.frame(
        "name" = approach$name[[i]],
        "Miss Distance (km)" = approach$close_approach_data[[i]][["miss_distance"]][["kilometers"]],
        "Miss Distance (mi)" = approach$close_approach_data[[i]][["miss_distance"]][["miles"]],
        "Relative Velocity (km/hr)" = approach$close_approach_data[[i]][["relative_velocity"]][["kilometers_per_hour"]],
        "Relative Velocity (m/hr)" = approach$close_approach_data[[i]][["relative_velocity"]][["miles_per_hour"]],
        "Approach Date" = approach$close_approach_data[[i]][["close_approach_date"]],
        stringsAsFactors = FALSE
      )
    }
  } else {
    objects2[[i]] <- data.frame()
    
  }
}

# Initiates the binding of multiple dataframes into one dataframe
almost_done <- objects2[[1]]
# Combines all the dataframes together
for (i in 2:length(objects2)) {
  almost_done <- rbind(almost_done, objects2[[i]])
}

# Initiates the binding of multiple dataframes into one datframe
getting_there <- objects[[1]]
# Combines all the dataframes together
for (i in 2:length(objects)) {
  getting_there <- rbind(getting_there, objects[[i]])
}

# A single dataframe containing all the information
completed <- left_join(almost_done, getting_there)

# Plots the graphic

get_graphic <- function() {
  
  plot_ly(completed, x = completed$Approach.Date,
          y = completed$Maximum.Estimated.Diameter..km.,
          text = paste("Name:", completed$name, 
                       "<br>Size:", completed$Maximum.Estimated.Diameter..km.,
                       "km",
                       "<br>Speed:", completed$Relative.Velocity..km.hr.,
                       "km/hr",
                       "<br>Approach Date:", completed$Approach.Date),
          type = "scatter", mode = "markers", color = completed$name,
          marker = list(size = (as.numeric(completed$Miss.Distance..km.)
                                / 1000000),
                        color = brewer.pal(12, "Paired")),
          symbol = "circle") %>%
    layout(title = "Asteroid Graphic", 
           xaxis = list(showgrid = FALSE,
                        title = "Approach Date"),
           yaxis = list(showgrid = FALSE,
                        title = "Maximum Diameter in Kilometers"))
}

graph <- get_graphic()
