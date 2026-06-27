library(shiny)

# Define UI for application that draws a histogram
fluidPage(

  # Application title
  titlePanel("Interactive Modeler: Old Faithful Geyser Eruptions"),

  sidebarLayout(
    sidebarPanel(
      helpText("This app lets you explore the relationship between eruption duration and waiting time in the Old Faithful geyser dataset in R. ",
               "Use the sliders to choose which eruptions to include, and press 'Submit Model' to update the filtered data and refit the linear model. ",
               "If the model is enabled, enter an eruption duration and press 'Submit Prediction' to estimate the expected waiting time. "
               ),
      
      tags$hr(),
      
      sliderInput("minEruption", "Filter out eruptions below the specified duration (minutes):",
                  min = 1, max = 5.5, value = 1),
      
      sliderInput("minWait", "Filter out eruptions with wait time below the specified length (minutes):",
                  min = 40, max = 100, value = 40),
      
      checkboxInput("fitModel", "Fit a linear model of the relationship between eruption duration and wait time", TRUE),
      
      actionButton("submitModel", "Submit Model"),
      
      tags$hr(),
      
      numericInput("predEruption", "Predict the wait time for the specified eruption duration (minutes):",
                   value = 3, min = 1, max = 5.5, step = 0.1),
      
      actionButton("submitPrediction", "Predict")
    ),
    
    mainPanel(
      plotOutput("scatter"),
      verbatimTextOutput("modelSummary"),
      verbatimTextOutput("prediction")
    )
  )
)