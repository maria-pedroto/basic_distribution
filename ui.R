library(shiny)
library(ggplot2)
shinyUI(fluidPage(
    
  titlePanel("Simple Distributions Graphs Example App"),

  sidebarLayout(
    sidebarPanel(
      radioButtons("dist", "Distribution type:",
                   c("Normal" = "norm",
                     "Uniform" = "unif",
                     "Log-normal" = "lnorm",
                     "Exponential" = "exp",
					 "Cauchy" = "cauchy")),
      br(),
      
      sliderInput("n", 
                  "Number of observations:", 
                   value = 500,
                   min = 100, 
                   max = 10000)
    ),
    
    # Show a tabset that includes a plot, summary, and table view
    # of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs", 
        tabPanel("Plot", plotOutput("plot")), 
        tabPanel("Summary", verbatimTextOutput("summary")), 
        tabPanel("Table", tableOutput("table"))
      )
    )
  )
))