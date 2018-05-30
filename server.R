source("distance_analysis.r")
source("static_map.R")



# Start shinyServer
shinyServer(function(input, output) { 
  
  
  # Render Distance Bubble Map
    output$Distance <- renderPlotly(
      graph
    )
  
  # Render Static Map based on Date
  output$var_chosen <- renderPrint({ input$var_chosen })
  output$dates <- renderPrint({ input$dates })
  
  output$static <- renderPlotly(get_graph(input$dates, input$var_chosen))
    
    
  
  # Render Information Tab about the asteroids as a whole
  
})