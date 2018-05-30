source("distance_analysis.r")
source("static_map.R")



# Start shinyServer
shinyServer(function(input, output) { 
  
  
  # Render Distance Bubble Map
    output$Distance <- renderPlotly(
      graph
    )
  
  # Render Static Map based on Date
  output$var_value <- renderPrint({ input$var_chosen })
  output$date_value <- renderPrint({ input$date })
  
  output$static <- renderPlotly(get_graph(input$date, input$var_chosen))
    
    
  
  # Render Information Tab about the asteroids as a whole
  
})