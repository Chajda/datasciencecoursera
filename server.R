# test application for Coursera Developing Data Products
# Chajda @ 2015
library(shiny)
shinyServer(
  function(input, output) {
    pattern <- reactive({input$pattern})
    x <- reactive({input$x})
    choices <- reactive({input$choices})
    invert <- reactive({input$invert})
    age <- reactive({input$age})
    #
    output$text1 <- renderText({
      0L != length(grep(pattern(), x(),
        ignore.case = "i" %in% choices(),
        perl = "p" %in% choices(),
        value = "v" %in% choices(),
        fixed = "f" %in% choices(),
        useBytes = "u" %in% choices(),
        invert= 1 == invert()))
    })
  }
)
