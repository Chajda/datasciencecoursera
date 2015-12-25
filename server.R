# test application for Coursera Developing Data Products
# Chajda @ 2015
library(shiny)
shinyServer(
  function(input, output) {
    name <- reactive({input$name})
    multiplicator <- reactive({input$multiplicator})
    radioBox <- reactive({input$radioBox})
    age <- reactive({input$age})

    output$text1 <- renderText({paste("Hallo ", name())})
    output$text2 <- renderText({as.numeric(age())*as.numeric(multiplicator())})
  }
)
