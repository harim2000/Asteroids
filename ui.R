# ui.R
library(shiny)
library(shinythemes)

shinyUI(navbarPage(theme = shinytheme("cyborg"),
                   "NASA Asteroids Data",
  
  # tab for Introduction
  tabPanel(
    "Introduction",
    tags$h1("Asteroids Data from NASA"),
    #tags$audio(src = "Light-Years_v001.mp3", type = "audio/mp3", autoplay = NA, controls = NA),
    tags$embed(src="Deep-Space.mp3", height=0, width=0),
    mainPanel(
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
      
      # First paragraph about Astetoids
      tags$div(class = "paragraph", checked = NA,
              tags$h3("What are Asteroids"),
              tags$p("Asteroids literally means star-like. According to NASA's definition: "),
              tags$img(src='pic2.jpg', width = "347px", height = "196px", align = "right"),
              tags$blockquote(" Asteroids are rocky, airless worlds that orbit our sun, but are too 
                    small to be called planets. Tens of thousands of these minor planets 
                    are gathered in the main asteroid belt, a vast doughnut-shaped ring 
                    between the orbits of Mars and Jupiter. Asteroids that pass close to 
                    Earth—and merit close watch—are called Near-Earth Objects, or NEOs. 
                    The current known asteroid count is:", cite = "NASA",
                    tags$b(" 779,939"))
              ),
      
      tags$div(class = "paragraph", checked = NA,
              tags$h3("About the Data"),
              tags$img(src='nasa.png', width = "228px", height = "180px", align = "left"),
              tags$p("All the data to create this web page is from the NASA JPL Asteroid team",
                    tags$a(href="http://neo.jpl.nasa.gov/", "(http://neo.jpl.nasa.gov/)."),
                    "Specifically, we investigated NeoWs (Near Earth Object Web Service), 
                    which is a RESTful web service for near earth Asteroid information. 
                    NeoWs allows a user to do: search for Asteroids based on their closest 
                    approach date to Earth, lookup a specific Asteroid with its NASA JPL 
                    small body id, as well as browse the overall data-set."),
              tags$p("The", tags$a(href="https://api.nasa.gov/index.html", "API"), 
                    " was collected and is maintained by - SpaceRocks Team: 
                    David Greenfield, Arezu Sarvestani, Jason English and Peter Baunach. 
                    We found information about this data from aprogrammableweb, 
                    a website that has different kinds of APIS to explore.")
              ),
      
      tags$div(class = "paragraph", checked = NA,
              tags$h3("What This Application Does"),
              tags$p("On this web page, there are three main tabs that you can explore and 
                    find out about the current asteroids around the earth:"),
              tags$li(tags$b("Distance")),
              tags$p("The first tab shows the distance between the earth and asteroids"),
              tags$li("Static Map"),
              tags$p("This interactive map shows..."),
              tags$li("Asteroids Information"),
              tags$p("This allows you to explore the detail of a specific asteroids from 
                    the data. It includes the distance from the earth")
              ),
      
      tags$div(class = "bibliography", checked = NA,
              tags$hr(),
              tags$p("Bibliography"),
              tags$p("Data and Info:",
                tags$a(href="http://neo.jpl.nasa.gov/", "CNEOS,"),
                tags$a(href="https://api.nasa.gov/index.html", "NASA APIs,"),
                tags$a(href="https://solarsystem.nasa.gov/small-bodies/asteroids/exploration/
                       ?page=0&per_page=10&order=launch_date+desc%2Ctitle+asc&search=&category=
                       33&tags=Asteroids#first-of-the-belt", 
                       "Solar System Exploration"),
                tags$br(),
                "Pictures:",
                tags$a(href="https://www.nasa.gov/mission_pages/WISE/news/wise20130529.html", 
                    "Background Picture,"),
                tags$a(href="http://www.lavanguardia.com/ciencia/fisica-espacio/20180204/44469990019/
                    asteroide-2002-aj129-tierra-directo.html", "Asteroid")
              )
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
  
  # tab for Asteroids Information
  tabPanel(
    "The Asteroids",
    tags$h1("Detailed information about the asteroids as a whole")
  )
))
