# View HTML tags with ?builder
# Note the server function can/should be in its own file, separate from
# the shinyUI statement

# ______________________________________________________________________________

library(shiny)

shinyServer(function(input, output) {
  
    output$text1 = renderText(input$slider2 + 10)
    
})
# ______________________________________________________________________________

shinyUI(fluidPage(
  titlePanel("Data science!"),
  sidebarLayout(
    sidebarPanel(
      h1("H1"),
      h2("H2"),
      h3("Sidebar text"),
      em("Emphasized text"),
      h1("Move the slider"),
      sliderInput("slider2", "Slide me", 0, 100, 0)
    ),
    mainPanel(
      h3("Slider Value:"),
      textOutput("text1")
      code("Some code here")
    )
  )
))

# ______________________________________________________________________________

shinyServer(function(input, output) {
  output$plot1 <- renderPlot({
    set.seed(2026-06-22)
    number4_of_points <- input$numeric
    minX <-0 input$sliderX[1]
    maxX <- input$sliderX[2]
    minY <- input$sliderY[1]
    maxY <- input$sliderY[2]
    dataX <- runif(number_of_points, minX, maxX)
    dataY <- runif(number_of_points, minY, maxY)
    xlab <- ifelse(input$show_xlab, "X Axis", "")
    ylab <- ifelse(input$show_ylab, "Y Axis", "")
    main <- ifelse(input$show_title, "Title", "")
    plot(dataX, dataY, xlab = xlab, ylab = ylab, main = main,
         xlim = c(-100, 100), ylim = c(-100, 100))
  })
})

# ______________________________________________________________________________

shinyUI(fluidPage(
  titlePanel("Plot Random Numbers"),
  sidebarLayout(
    sidebarPanel(
      numericInput("numeric", "How many random numbers should be plotted?",
                   value = 1000, min = 1, max = 1000, step = 1),
      sliderInput("sliderX", "Pick minimum and maximum X values",
                  -100, 100, value = c(-50, 50)),
      sliderInput("sliderY", "Pick minimum and maximum Y values",
                  -100, 100, value = c(-50, 50)),
      checkboxInput("show_xlab", "Show/Hide x axis label", value = TRUE),
      checkboxInput("show_ylab", "Show/Hide y axis label", value = TRUE),
      checkboxInput("show_title", "Show/Hide Title")
    ),
    mainPanel(
      h3("Graph of Random Points"),
      plotOutput("plot1")
    )
  )
))

# ______________________________________________________________________________

# Reactive example:
variable <- reactive({
  input$input1 + input$input2
})

variable

# Delayed reactivity
submitButton("Submit")

# ______________________________________________________________________________

# Tabs
sidebarLayout(
  sidebarPanel(
    textInput("box1", "Enter Tab 1 Text:", value = "Tab1!")
  )
)
mainPanel(
  tabsetPanel(type = "tabs",
              tabPanel("tab 1", br(), textOutput("out1")))
)

# ______________________________________________________________________________