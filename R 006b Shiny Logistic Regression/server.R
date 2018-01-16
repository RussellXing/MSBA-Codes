library(shiny)

dataset <- read.csv(paste(getwd(),"/kickers.csv",sep=""), header = TRUE)

shinyServer(function(input, output){
  output$v1 <- renderText(input$Variable)
  
  output$summary<-renderPrint({
    Success <- dataset$Success
    Variable <- dataset[,input$Variable]
    logreg <- glm(Success ~ Variable,family = binomial)
    print(summary(logreg))
  })
  
  output$plot <- renderPlot({
    Success <- dataset$Success
    Variable <- dataset[,input$Variable]
    logreg <- glm(Success ~ Variable,family = binomial)
    plot(Success ~ Variable)
    curve(predict(logreg, data.frame(Variable = x),type="resp"),add=TRUE)
    points(Variable, fitted(logreg))
  })
  
})