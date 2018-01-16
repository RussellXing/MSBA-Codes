library(shiny)

shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Choose CSV File",
                accept = c(
                  'text/csv',
                  'text/comma-separated-values',
                  'text/tab-separated-values',
                  'text/plain',
                  '.csv',
                  '.tsv')
      ),
      

      selectInput('Variable', 'Variable', choices = c('ScoreDiff', 'Distance'))
    ),
    mainPanel(
      h3("logistic regression summary"),
      
      "Variable selected:",
      textOutput("Variable"),
      
      tabsetPanel(
        tabPanel("Table Output", tableOutput("content")),
        
        tabPanel("Text Output", verbatimTextOutput("summary")),
        
        tabPanel("Plot", plotOutput("plot"))
      )
    )
  )
))