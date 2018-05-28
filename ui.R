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
    mainPanel(
      plotlyOutput("Distance")
    )
  ),
  
  tabPanel(
    "Static Map based on Date",
    tags$h1("Static Map based on Date")
  ),
  
  tabPanel(
    "The asteroids as a whole",
    tags$h1("Information Tab about the asteroids as a whole")
  )
))
