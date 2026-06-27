library(shiny)

function(input, output) {

  # Build data set based on input duration and wait time
  filtered <- eventReactive(input$submitModel, {
    faithful[faithful$eruptions >= input$minEruption &
               faithful$waiting >= input$minWait, ]
  })
  
  # Build model that predicts wait time based on eruption duration
  model <- eventReactive(input$submitModel, {
    req(input$fitModel)
    lm(waiting ~ eruptions, data = filtered())
  })
  
  prediction <- eventReactive(input$submitPrediction, {
    predict(model(), 
            newdata = data.frame(eruptions = isolate(input$predEruption)))
  })
  
  # Output scatter plot, model summary, and predicted wait time
  output$scatter <- renderPlot({
    data <- filtered()
    plot(data$eruptions, data$waiting,
         xlab = "Eruption Duration (Minutes)",
         ylab = "Waiting Time Between Eruptions (Minutes)",
         pch = 19, col = rgb(0, 0, 1, 0.3))
    
    if (input$fitModel) {
      abline(model(), col = "red", lwd = 2)
    }
  })
  
  output$modelSummary <- renderPrint({
    if (input$fitModel) summary(model())
  })
  
  output$prediction <- renderPrint({
    if (input$fitModel) {
      pred <- prediction()
      paste("Predicted Wait Time:", round(pred, 1), "minutes")
    }
  })
}