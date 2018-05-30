# ui.R
library(shiny)
library(shinythemes)

shinyUI(navbarPage(theme = shinytheme("cyborg"),
                   "NASA Asteroids Data",
  # tab for Introduction
  tabPanel(
    "Introduction",
    tags$h1("Asteroids Data from NASA"),
    tags$img(src='pic1.jpg', width = "1400px", height = "800px", align = "left"),
    
    mainPanel(
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
      tags$div(class = "summary", checked = NA,
               tags$p("About Data set")
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
