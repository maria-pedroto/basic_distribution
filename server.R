library(shiny)
library(ggplot2)
shinyServer(function(input, output) {
  
  data <- reactive({
    dist <- switch(input$dist,
                   norm = rnorm,
                   unif = runif,
                   lnorm = rlnorm,
                   exp = rexp,
				   beta = rbeta,
				   binom = rbinom,
				   cauchy = rcauchy,
				   chisq = rchisq,
				   rf = rf,
				   rgeom = rgeom,
                   rnorm)
    dist(input$n)
  })
  
  output$plot <- renderPlot({
    dist <- input$dist
    n <- input$n
	dataframe <- data.frame(data())
	colnames(dataframe) <- c("data")
    
	par(mfrow=c(2,2))
	
    hist(dataframe$data, 
         main=paste('r', dist, '(', n, ')', sep=''),
		 xlab="Histogram",
		 ylab="Frequency");
	abline(v=mean(dataframe$data),col="blue")
	boxplot(dataframe$data, 
		main=paste('r', dist, '(', n, ')', sep=''),
		xlab="Boxplot",
		ylab="");
	qqnorm(dataframe$data);
	plot(density(dataframe$data))
  })
  
  output$summary <- renderPrint({
    summary(data())
  })
  
  output$table <- renderTable({
    data.frame(x=data())
  })
  
})