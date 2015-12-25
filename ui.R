# test application for Coursera Developing Data Products
# Chajda @ 2015
library(shiny)
# Define UI for application
shinyUI(pageWithSidebar(
  headerPanel("Illuminate application"),
  sidebarPanel(
    h3("Inputs:"),
    textInput("name", "What's your name?", ""),
    sliderInput("age", "Your Age?", min = 0, max = 140, value = 0),
    checkboxGroupInput("multiplicator", "Multiplicator?", c("100x"="100", "10x"="10", "0.1x"="0.1"), 0),
    radioButtons("radioBox", "RadioBox", c("Male"="0", "Female"="1"))
  ),
  mainPanel(
    h3("Outputs:"),
    helpText('Greatings'),
    textOutput("text1"),
    helpText('Your illuminaters numerous'),
    textOutput("text2")
  )
))
