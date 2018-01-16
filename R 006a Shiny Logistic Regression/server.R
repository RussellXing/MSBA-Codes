library(shiny)

dataset <- read.csv(paste(getwd(),"/kickers.csv",sep=""), header = TRUE)

shinyServer(function(input, output){
  output$Variable <- renderText(input$Variable)
  
  output$summary<-renderPrint({
    Success <- dataset$Success
    Variable <- dataset[,input$Variable]
    logreg <- glm(Success ~ Variable,family = binomial)
    print(summary(logreg))
  })
  
})