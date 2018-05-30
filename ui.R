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
    tags$h1("Static Map based on Date"),
    sidebarPanel(
      dateRangeInput("dates", label = h3("Select dates to observe: ")),
      selectInput("var_chosen", label = h3("Select variable to observe: "),
                  choices = list("Absolute Magnitude" = 1,
                                 "Estimated Maximum Diameter (Feet)" = 2,
                                 "Estimated Minimum Diameter (Feet)" = 3,
                                 "Relative Speed" = 4), 
                  selected = 4)
    ),
    mainPanel(
      plotlyOutput("static")
    )
  ),
  
  tabPanel(
    "The asteroids as a whole",
    tags$h1("Information Tab about the asteroids as a whole")
  )
))
