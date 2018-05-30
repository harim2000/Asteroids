library(jsonlite)
library(httr)
library(dplyr)
library(plotly)
library(ggrepel)
source("apikey_justin.R")

# Sets up the parameters and queries for the API and
# GET request
base_uri <- "https://api.nasa.gov/neo/rest/v1/neo/"
resource <- "browse"
query_params <- list(api_key = api)
endpoint <- paste0(base_uri, resource)


# Performs the GET request to retrieve the information from
# the NASA API
response <- GET(endpoint, query = query_params)
body <- content(response, "text")
data <- fromJSON(body)
df <- data$near_earth_objects
od <- data$near_earth_objects$orbital_data
ed <- data$near_earth_objects$estimated_diameter$kilometers %>% 
  mutate(mean_ed = (estimated_diameter_min + estimated_diameter_max) / 2) %>% 
  select(mean_ed)
  

relevant <- data.frame(
  "Aphelion Distance" = round(as.numeric(od$aphelion_distance), 2),
  "Peihelion Distance" = round(as.numeric(od$perihelion_distance), 2),
  "Orbital Period" = round(as.numeric(od$orbital_period), 2),
  "Inclination" = round(as.numeric(od$inclination), 2),
  "Eccentricity" = round(as.numeric(od$eccentricity), 2),
  "Estimated Diameter (Kilometers)" = round(as.numeric(ed$mean_ed) ,2),
  stringsAsFactors = F,
  check.names = F
)


