# ui.R
library(shiny)
library(shinythemes)

shinyUI(navbarPage(theme = shinytheme("sandstone"),
                   "NASA Asteriods Data",
  # Create a tab panel for your map
  tabPanel(
    "Introduction",
    tags$h1("Introduction")
  ),
  
  tabPanel(
    "Distance",
    tags$h1("Distance Analysis Bubble Map"),
    tags$p("This is a graphic of asteroids dataset from the NASA.
           It's main focus is on the miss distance of each asteroid.
           The size of the circle represents how much distance will
           each asteroid miss the Earth by."),
    plotlyOutput("Distance")
  ),
  
  tabPanel(
    "Static Map based on Date",
    tags$h1("Static Map based on Date"),
    plotlyOutput("Date")
  ),
  
  tabPanel(
    "The asteroids as a whole",
    tags$h1("Information Tab about the asteroids as a whole")
  )
))
