library(shiny)

shinyUI(fluidPage(
  titlePanel(title = "logistic regression"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput('Variable', 'Variable', choices = c('ScoreDiff', 'Distance'))
      ),
  mainPanel(h3("logistic regression summary"),
            
            "Variable you chose:",
            textOutput("Variable"),
            
            "Model Summary:",
            verbatimTextOutput("summary")
  )
  )
))