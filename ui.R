# test application for Coursera Developing Data Products
# Chajda @ 2015
library(shiny)
# Define UI for application
shinyUI(pageWithSidebar(
  headerPanel("R Function grep"),
  sidebarPanel(
    helpText("Search for matches to argument pattern within each element of a character vector."),
    h3("Inputs:"),
    textInput("pattern", "pattern", ""),
    helpText("pattern = character string containing a regular expression (or character string for fixed = TRUE) to be matched in the given character vector."),
    textInput("x", "x", ""),
    helpText("x = a character vector where matches are sought."),
    checkboxGroupInput("choices", "Choices", c(
      "ignore.case"="i",
      "perl"="p",
      "value"="v",
      "fixed"="f",
      "useBytes"="u")),
    helpText("ignore.case = if FALSE, the pattern matching is case sensitive and if TRUE, case is ignored during matching."),
    helpText("perl = Should Perl-compatible regexps be used?"),
    helpText("value = if FALSE, a vector containing the (integer) indices of the matches determined by grep is returned, and if TRUE, a vector containing the matching elements themselves is returned."),
    helpText("fixed =  If TRUE, pattern is a string to be matched as is. Overrides all conflicting arguments."),
    helpText("useBytes = If TRUE the matching is done byte-by-byte rather than character-by-character."),
    radioButtons("invert", "invert", c("FALSE"="0", "TRUE"="1")),
    helpText(" If TRUE return indices or values for elements that do not match."),
    sliderInput("age", "Your Age?", min = 0, max = 140, value = 0)
  ),
  mainPanel(
    h3("Outputs:"),
    helpText('Result:'),
    textOutput("text1")
  )
))
