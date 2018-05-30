# ui.R
library(shiny)
library(shinythemes)
library(plotly)
source("asteroid.R")

shinyUI(navbarPage(
  theme = shinytheme("cyborg"),
  "NASA Asteroids Data",

  # tab for Introduction
  tabPanel(
    "Introduction",
    tags$h1("Asteroids Data from NASA"),
    tags$audio(src = "Deep-Space.mp3", height = 0, width = 0),
    mainPanel(
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),

      # First paragraph about Astetoids
      tags$div(
        class = "paragraph", checked = NA,
        tags$h3("What are Asteroids"),
        tags$p("Asteroids literally means star-like, sometimes called minor planets, 
               are rocky remnants left over from the early formation of our solar system 
               about 4.6 billion years ago. According to NASA's definition: "),
        tags$img(src = "pic2.jpg", width = "330px", height = "186px", align = "right"),
        tags$blockquote(" Asteroids are rocky, airless worlds that orbit our sun, but are too 
                    small to be called planets. Tens of thousands of these minor planets 
                    are gathered in the main asteroid belt, a vast doughnut-shaped ring 
                    between the orbits of Mars and Jupiter. Asteroids that pass close to 
                    Earth -and merit close watch- are called Near-Earth Objects, or NEOs. 
                    The current known asteroid count is:",
          cite = "NASA",
          tags$b(" 779,944")
        )
      ),

      tags$div(
        class = "paragraph", checked = NA,
        tags$h3("About the Data"),
        tags$img(src = "nasa.png", width = "228px", height = "180px", align = "left"),
        tags$p(
          "All the data to create this web page is from the NASA JPL Asteroid team",
          tags$a(href = "http://neo.jpl.nasa.gov/", "(http://neo.jpl.nasa.gov/)."),
          "Specifically, we investigated NeoWs (Near Earth Object Web Service), 
                    which is a RESTful web service for near earth Asteroid information. 
                    NeoWs allows a user to do: search for Asteroids based on their closest 
                    approach date to Earth, lookup a specific Asteroid with its NASA JPL 
                    small body id, as well as browse the overall data-set."
        ),
        tags$p(
          "The", tags$a(href = "https://api.nasa.gov/index.html", "API"),
          " was collected and is maintained by - SpaceRocks Team: 
                    David Greenfield, Arezu Sarvestani, Jason English and Peter Baunach. 
                    We found information about this data from",
          tags$a(href = "https://www.programmableweb.com/api/nasa-asteroids-neo-feed", 
                 "aprogrammableweb"),
                    " a website that has different kinds of APIS to explore."
        )
      ),

      tags$div(
        class = "paragraph", checked = NA,
        tags$h3("What This Application Does"),
        tags$p("On this web page, there are three main tabs that you can explore and 
                    find out about the current asteroids around the earth:"),
        tags$li(tags$b("Distance")),
        tags$p("Distance Analysis Bubble Map shows the miss distance of each asteroids. 
               The size of bubble is the miss distance from the earth. Pointing the bubbles 
               also show the details of asteroids: name, size, speed, approach date, 
               and the miss distance."),
        tags$li(tags$b("Static Map")),
        tags$p("This interactive map shows the relationships between different 
               sets of data for todays asteroids. It runs through the given
               date and its previous week"),
        tags$li(tags$b("Asteroids Overview")),
        tags$p("Explore asteroids as a whole. Asteroids overview chart is an interactive 
               chart where you can choose two variables to see the relationship and compare 
               asteroids. Variables are Aphelion Distance, Perihelion Distance, Orbital Period, 
               Inclination, Eccentricity, Estimated Diameter (in km).")
      ),

      tags$div(
        class = "bibliography", checked = NA,
        tags$hr(),
        tags$p("Bibliography"),
        tags$p(
          "Data and Info:",
          tags$a(href = "http://neo.jpl.nasa.gov/", "CNEOS,"),
          tags$a(href = "https://api.nasa.gov/index.html", "NASA APIs,"),
          tags$a(
            href = "https://solarsystem.nasa.gov/small-bodies/asteroids/exploration/
                       ?page=0&per_page=10&order=launch_date+desc%2Ctitle+asc&search=&category=
                       33&tags=Asteroids#first-of-the-belt",
            "Solar System Exploration"
          ),
          tags$br(),
          "Pictures:",
          tags$a(
            href = "https://www.nasa.gov/mission_pages/WISE/news/wise20130529.html",
            "Background Picture,"
          ),
          tags$a(href = "http://www.lavanguardia.com/ciencia/fisica-espacio/20180204/44469990019/
                    asteroide-2002-aj129-tierra-directo.html", "Asteroid")
        )
      )
    )
  ),

  # tab for Distance Map
  tabPanel(
    "Distance",
    tags$h1("Distance Analysis Bubble Map"),
    tags$p("This is a graphic of asteroids dataset from the NASA.
           It's main focus is on the miss distance of each asteroid.
           The size of the circle represents how much distance will
           each asteroid miss the Earth by."),
    plotlyOutput("Distance"),
    tags$h1("Distance Analysis Bubble Map")
  ),

  # tab for Static Map
  tabPanel(
    "Static Map",
    tags$h1("Static Map based on Today's Date"),
    sidebarPanel(
      dateInput("date", label = h3("Select dates to observe: "),
                format = "yyyy-mm-dd")
    ),
    mainPanel(
      plotlyOutput("static")
    )
  ),

  # tab for Asteroids Information
  tabPanel(
    "Asteroids",
    sidebarLayout(
      sidebarPanel(
        tags$h1("Asteroid Overview"),
        selectInput(
          "col1",
          label = "Asteroid Data # 1",
          choices = colnames(relevant)
        ),
        selectInput(
          "col2",
          label = "Asteroid Data # 2",
          choices = colnames(relevant)
        )
      ),
      mainPanel(plotOutput("scatter"))
    )
  )
))
