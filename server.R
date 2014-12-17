#setwd("C:\\Users\\srobin\\Documents\\GitHub\\devDataProducts") 

library(shiny)
library(ggplot2)
library(stats)
library(car)


shinyServer(function(input, output) {
  
  dataset <- reactive(function() {
    
       mtcars[mtcars$cyl==input$cyl,]
    
  })

  pred <- reactive(function(){
    fit <- lm_formula
    newData <- data.frame(cyl=input$cyl,hp=input$hp,wt=input$wt,drat=input$drat)
    predict(fit,newData)
    
  })

  # find the closest car to the mpg
  pickCar <- reactive(function(){

    num <- which(abs(dataset()$mpg-pred())==min(abs(dataset()$mpg-pred())))  
    row.names(dataset())[num]
    
  })
  
# print answer
  output$mytext <- renderText({ 
    HTML(paste("Predicted Miles Per Gallon", round(pred(),2)))
    
  }) 
  output$mytext2 <- renderText({ 
    HTML(paste("You might like the ", pickCar()))
  
  }) 

  output$plot <- renderPlot(function() {
    data <- dataset()
      
     p <- ggplot(data, aes(mpg, hp) )  +  geom_text(label=rownames(data),hjust=0, vjust=0,angle = 45)
     p <- p + geom_point(colour="blue", size =4)
     p <- p + geom_smooth(method=lm)
     p <- p + geom_vline(xintercept = pred(), colour="red", size=1)
     
    
   
    print(p)
    
  }, height=400)

  output$table <- renderTable(function(){
    dataset()[pickCar(),]
    
  })

})