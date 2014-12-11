#setwd("C:\\Users\\srobin\\Documents\\GitHub\\devDataProducts")

library(shiny)
library(ggplot2)
library(car)
library(randomForest)

shinyUI(pageWithSidebar(
  
  headerPanel("70's AutoMotors"),
  
  sidebarPanel(
    h3("MPG Explorer"),
    img(src="datsun710.jpg", height = 200, width = 220),
    br(),
    br(),
  
    selectInput('cyl', 'Cylinders', 
                choices=c(4,6,8)),
    
      sliderInput('hp','HorsePower', 
                  min = min(dataset$hp), 
                  max = max(dataset$hp), 
                  value = mean(dataset$hp), step=20),

      sliderInput('wt', 'Weight (1000)', 
                  min = min(dataset$wt), 
                  max = max(dataset$wt), 
                  value = mean(dataset$wt), step = .2),

      sliderInput('drat', 'Rear Gear Ratio', 
                  min = min(dataset$drat), 
                  max = max(dataset$drat), 
                  value = mean(dataset$drat), step = .2),

    tags$br(),
    tags$br()
    
    
  ),
  
  mainPanel(
    h3(textOutput('mytext')),
    h2(textOutput('mytext2')),
    plotOutput('plot'),
    tableOutput('table')
  )
))