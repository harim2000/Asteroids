source("distance_analysis.r")



# Start shinyServer
shinyServer(function(input, output) { 
  
  
  # Render Distance Bubble Map
    output$Distance <- renderPlotly(
      graph
    )
  
  # Render Static Map based on Date
  
  
  # Render Information Tab about the asteroids as a whole
  
})