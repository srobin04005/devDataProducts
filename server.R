#setwd("C:\\Users\\srobin\\Documents\\GitHub\\devDataProducts") 

library(shiny)
library(ggplot2)
library(stats)
library(car)
library(randomForest)

shinyServer(function(input, output,session) {
  
  dataset <- reactive(function() {
    
       mtcars[mtcars$cyl==input$cyl,]
    
  })

  pred <- reactive(function(){
    
    fit <- switch(input$formula,
                   linear=lm_formula,
                  randomForest=rf_formula,
                  lm)
    newData <- data.frame(cyl=as.numeric(input$cyl),
                          hp=input$hp,
                          wt=input$wt,
                          drat=input$drat,
                          gear=input$gear,
                          carb=input$carb,
                          disp=input$disp
                          )
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

getCyl <- reactive(function(){
  ncyl <-  dataset()[pickCar(),2]
})

observe({
  # Updates the sliders to the average for the cylinder selected.
 
  
  updateSliderInput(session, "hp",
                    label = "HP (Updated)",
                    value = dataset()$hp)
  updateSliderInput(session, "wt",
                    label = "Weight (UPDated)",
                    value = dataset()$wt)
  updateSliderInput(session, "drat",
                    label = "Rear Gear (UPDated)",
                    value = dataset()$drat)
  updateSliderInput(session, "gear",
                    label = "Forward Gear (UPDated)",
                    value = dataset()$gear)
  updateSliderInput(session, "carb",
                    label = "Number of Carbs (UPDated)",
                    value = dataset()$carb)
  updateSliderInput(session, "disp",
                    label = "Displacement (UPDated)",
                    value = dataset()$disp)
})
  output$plot <- renderPlot(function() {
    data <- dataset()
      
     p <- ggplot(data, aes(mpg, hp) )  
     p <- p +  geom_text(label=rownames(data),hjust=0, vjust=0,angle = 45)
     p <- p + geom_point(colour="blue", size =4)
     p <- p + geom_smooth(method=lm)
     p <- p + geom_vline(xintercept = pred(), colour="red", size=1)
     
    
   
    print(p)
    
  }, height=400)

  output$table <- renderTable(function(){
    dataset()[pickCar(),]
    
  })

})