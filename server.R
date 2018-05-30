source("asteroid.r")
source("distance_analysis.r")
<<<<<<< HEAD
#source("static_map.R")

=======
source("static_map.R")
>>>>>>> 741e280990aa9cf7cba208ee1014a4aac1b31645


# Start shinyServer
shinyServer(function(input, output) {


  # Render Distance Bubble Map
  output$Distance <- renderPlotly(
    graph
  )

  # Render Static Map based on Date
<<<<<<< HEAD

  
  
=======
  output$var_chosen <- renderPrint({
    input$var_chosen
  })
  output$dates <- renderPrint({
    input$dates
  })

  output$static <- renderPlotly(get_graph(input$dates, input$var_chosen))

>>>>>>> 741e280990aa9cf7cba208ee1014a4aac1b31645
  # Render Information Tab about the asteroids as a whole
  output$scatter <- renderPlot({
    title <- paste0("Relationship between ", input$col1, " and ", input$col2)
    p <- ggplot(data = relevant) +
      geom_point(
        mapping = aes(x = relevant[[input$col1]], y = relevant[[input$col2]], color = df$name),
        size = 8
      ) +
      labs(x = input$col1, y = input$col2, title = title) +
      theme_solarized_2(light = FALSE) +
      geom_label_repel(aes(
        x = relevant[[input$col1]], y = relevant[[input$col2]],
        label = df$name
      ),
      alpha = 0.5, box.padding = 1,
      point.padding = 0.5
      )
    p
  })
})
