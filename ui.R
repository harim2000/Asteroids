# ui.R
library(shiny)
library(shinythemes)

shinyUI(navbarPage(theme = shinytheme("cyborg"),
                   "NASA Asteroids Data",
  # tab for Introduction
  tabPanel(
    "Introduction",
    tags$h1("Asteroids Data from NASA"),
    tags$audio(src = "Light-Years_v001.mp3", type = "audio/mp3", autoplay = NA, controls = NA),
    
    mainPanel(
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
      tags$div(class = "data_set", checked = NA,
               tags$h3("About Data set"),
               tags$p("All the data to create this web page is from the 
                      NASA JPL Asteroid team (http://neo.jpl.nasa.gov/).
                      Specifically, we investigated NeoWs (Near Earth Object Web Service), 
                      which is a RESTful web service for near earth Asteroid information. 
                      NeoWs allows a user to do: search for Asteroids based on their closest 
                      approach date to Earth, lookup a specific Asteroid with its NASA JPL 
                      small body id, as well as browse the overall data-set. 
                      
                      The API was collected and is maintained by - SpaceRocks Team: 
                      David Greenfield, Arezu Sarvestani, Jason English and Peter Baunach. 
                      We found information about this data from aprogrammableweb, 
                      a website that has different kinds of APIS to explore"),
               tags$img(src='nasa.png', width = "570px", height = "450px", align = "left")
               ),
      tags$div(class = "about_asteroids", checked = NA,
               tags$h3("What are asteroids")
               )
    )
  ),
  
  # tab for Distance Map
  tabPanel(
    "Distance",
    tags$h1("Distance Analysis Bubble Map"),
    plotlyOutput("Distance", height = "100%")
  ),
  
  # tab for Static Map
  tabPanel(
    "Static Map based on Date",
    tags$h1("Static Map based on Date")
  ),
  
  # tab for Asteroids Information
  tabPanel(
    "The asteroids as a whole",
    tags$h1("Information Tab about the asteroids as a whole")
  )
))
