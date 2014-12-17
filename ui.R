#setwd("C:\\Users\\srobin\\Documents\\GitHub\\devDataProducts")  

library(shiny)
library(ggplot2)
library(car)


shinyUI(pageWithSidebar(
  
  headerPanel("70's AutoMotors"),
  
  sidebarPanel(
    h3("MPG Explorer"),
    img(src="datsun710.jpg", height = 200, width = 220),
    br(),
    br(),
    #sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
    #    value=min(10, nrow(dataset)), step=5, round=0),
    
    sliderInput('cyl', 'Cylinders', 
                min = 4,max = 8,value = 6,step = 2),
    sliderInput('hp', 'HorsePower', 
                min = min(mtcars$hp), max = max(mtcars$hp), 
                value= 175,step=20 ),
    sliderInput('wt', 'Weight (1000)', 
                min = min(mtcars$wt), max = max(mtcars$wt), 
                value=3.44, step = .2),
    sliderInput('drat', 'Rear Gear Ratio', 
                min = min(mtcars$drat), max = max(mtcars$drat), 
                value=4.5, step = .2),
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