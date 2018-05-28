source("distance_analysis.r")



# Start shinyServer
shinyServer(function(input, output) { 
  
  
  # Render Distance Bubble Map
    output$Distance <- renderPlotly(
      plot_ly(completed, x = completed$Approach.Date,
              y = completed$Maximum.Estimated.Diameter..km.,
              text = paste("Name:", completed$name, 
                           "<br>Size:", completed$Maximum.Estimated.Diameter..km.,
                           "km",
                           "<br>Speed:", completed$Relative.Velocity..km.hr.,
                           "km/hr",
                           "<br>Approach Date:", completed$Approach.Date),
              type = "scatter", mode = "markers", color = completed$name,
              marker = list(size = (as.numeric(completed$Miss.Distance..km.)
                                    / 1000000),
                            color = brewer.pal(12, "Paired")),
              symbol = "circle") %>%
        layout(title = "Asteroid Graphic", 
               xaxis = list(showgrid = FALSE,
                            title = "Approach Date"),
               yaxis = list(showgrid = FALSE,
                            title = "Maximum Diameter in Kilometers"))
    )
  
  # Render Static Map based on Date
  
  
  # Render Information Tab about the asteroids as a whole
  
})