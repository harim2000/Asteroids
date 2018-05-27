library(dplyr)
library(ggplot2)
library(plotly)
library(stringr)
library(jsonlite)
library(httr)


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
objects2 <- list()
approach <- near_earth_objects %>% select(name, close_approach_data)

# Extracts the Miss Distance information from the original dataframe
# and puts it into its own list for easier access
for (i in 1:nrow(near_earth_objects)) {
  
  last <- length(approach$close_approach_data[[i]][["miss_distance"]])
  
  if (last > 0) {
    for (j in 1:last) {
      objects2[[i]] <- data.frame(
        "name" = approach$name[[i]],
        "Miss Distance (km)" = approach$close_approach_data[[i]][["miss_distance"]][["kilometers"]],
        "Miss Distance (km)" = approach$close_approach_data[[i]][["miss_distance"]][["miles"]],
        stringsAsFactors = FALSE
      )
    }
  } else {
    next
  }
}


objects3 <- list()

for (i in 1:nrow(near_earth_objects)) {
  
  last <- length(approach$close_approach_data[[i]][["relative_velocity"]])
  
  if (last > 0) {
    for (j in 1:last) {
      objects3[[i]] <- data.frame(
        "name" = approach$name[[i]],
        "Relative Velocity (km/hr)" = approach$close_approach_data[[i]][["relative_velocity"]][["kilometers_per_hour"]],
        "Relative Velocity (m/hr)" = approach$close_approach_data[[i]][["relative_velocity"]][["miles_per_hour"]],
        stringsAsFactors = FALSE
      )
    }
  } else {
    next
  }
}

