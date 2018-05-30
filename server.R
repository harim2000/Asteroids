source("distance_analysis.r")
#source("static_map.R")



# Start shinyServer
shinyServer(function(input, output) { 
  
  
  # Render Distance Bubble Map
    output$Distance <- renderPlotly(
      graph
    )
  
  # Render Static Map based on Date

  
  
  # Render Information Tab about the asteroids as a whole
  
})