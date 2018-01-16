library(shiny)

shinyServer(function(input, output){
  dataset <- reactive({
    infile <- input$file1
    
    if (is.null(infile))
      return(NULL)
    
    read.csv(infile$datapath, header = TRUE)
  })
  
  output$Variable <- renderText(input$Variable)
  
  output$content <- renderTable(dataset())
  
  output$summary<-renderPrint({
    Success <- dataset()$Success
    Variable <- dataset()[,input$Variable]
    logreg <- glm(Success ~ Variable,family = binomial)
    print(summary(logreg))
  })
  
  output$plot <- renderPlot({
    Success <- dataset()$Success
    Variable <- dataset()[,input$Variable]
    logreg <- glm(Success ~ Variable,family = binomial)
    plot(Success ~ Variable)
    curve(predict(logreg, data.frame(Variable = x),type="resp"),add=TRUE)
    points(Variable, fitted(logreg))
  })
})