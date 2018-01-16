library(shiny)

shinyUI(fluidPage(
  titlePanel(title = "logistic regression"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput('Variable', 'Variable', choices = c('ScoreDiff', 'Distance'))
    ),
    mainPanel(h3("logistic regression summary"),
              
              "Variable:",
              textOutput("Variable"),
              
              tabsetPanel(
                
                tabPanel("Text Output",verbatimTextOutput("summary")),
                
                tabPanel("Plot",plotOutput("plot"))
              )
              
             
    )
  )
))