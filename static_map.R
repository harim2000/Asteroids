library(jsonlite)
library(httr)
library(dplyr)
library(plotly)
library(lubridate)

source("apikey.R")

get_graph <- function(date, var_viewed){

  date <- as.character(Sys.Date())

  var_viewed <- as.numeric(var_viewed)

  end_d <- parse_date_time(date, orders = c("ymd", "dmy", "mdy"))
  start_d <- end_d - days(6)

  # number of data sets from dates requested

  # get data from api
  url <- "https://api.nasa.gov/neo/rest/v1/feed"
  query_params <- list(start_date = start_d,
                       end_date = date,
                       api_key = apikey)

  response <- GET(url, query = query_params)

  response_content <- content(response, "text")
  data_harim <- fromJSON(response_content)

  # length of asteroids list will be equal to days
  days_observed <- data_harim$near_earth_objects[date]

  days_observed <- days_observed[[date]]


      # Get number of asteroids
  number_of_asteroids <- length(days_observed$name)
  asteroids <- data.frame(rows = c(1:number_of_asteroids), stringsAsFactors = F)

  # make a list of asteroids with all the dates requested, inside of each date
  # is a data frame full of the asteroids observed that day
  asteroids$name <- days_observed$name
  asteroids$id <- days_observed$neo_reference_id
  asteroids$url <- days_observed$nasa_jpl_url
  asteroids$absolute_magnitude <- days_observed$absolute_magnitude_h
  asteroids$estimated_diam_min_feet <- days_observed$
       estimated_diameter$feet$estimated_diameter_min
  asteroids$estimated_diam_max_feet <- days_observed$
       estimated_diameter$feet$estimated_diameter_max
  asteroids$potentially_dangerous <- days_observed$
       is_potentially_hazardous_asteroid

  # Gets specific data for the specific asteroid
  for (j in 1:length(days_observed$close_approach_data)){

    asteroids$miss_distance_a[[j]] <- days_observed$
      close_approach_data[[j]]$miss_distance$miles

    asteroids$relative_velocity_mph[[j]] <- days_observed$
      close_approach_data[[j]]$relative_velocity$miles_per_hour

    asteroids$orbiting_body[[j]] <- days_observed$
      close_approach_data[[j]]$orbiting_body
  }

  # start to make plot

  pot_dan_color <- c("red", "green")
  pot_dan_color <- setNames(pot_dan_color, c("TRUE", "FALSE"))

  plot <- plot_ly(asteroids, x = ~miss_distance_a, #sets x & y data
                  y = asteroids[, var_viewed],
                  type = "scatter",
                  mode = "markers",
                  text = ~paste("<br>Name: ", name, # Sets the hover text for
                                "<br>ID: ", id,     # each marker
                                "<br>", date,
                                "<br>Absolute Magnitude: ",
                                absolute_magnitude,
                                "<br>Estimated Max Diameter (Feet): ",
                                round(estimated_diam_max_feet, 2),
                                "<br>Estimated Min Diameter (Feet): ",
                                round(estimated_diam_min_feet, 2),
                                "<br>Potentially Dangerous: ",
                                potentially_dangerous,
                                "<br>Orbiting Body: ",
                                orbiting_body,
                                "<br> Miss Distance: ",
                                miss_distance_a, " miles"),
                  color = ~potentially_dangerous,
                  colors = ~pot_dan_color,
                  xaxis = list(autotick = FALSE),
                  yaxis = list(autotick = FALSE)) %>%
    layout(xaxis = list(title = "Miss Distance (miles)"),
           yaxis = list(title = colnames(asteroids)[var_viewed]))

  plot

}
