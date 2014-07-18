library(shiny)
library(ggplot2)
library(scales)
# library(bitops)
# library(httpuv)
library(reshape2)
# suppressPackageStartupMessages(library(googleVis))

load("data.rda")


shinyServer(function(input, output) {
        
        #creates reactive formula for the input variables
        ccaa.sel <- reactive({
            c("Total",input$ccaa1, input$ccaa2)
        })
        
      
        forma.sel <- reactive({
            input$nforma
        })
        
        auxi <- reactive({
            sel <- data$ccaa %in% ccaa.sel()
            auxi <- data[sel,]            
        })

        # renderPlot
        output$plot1 <- renderPlot({

            p <- ggplot(auxi(), aes(x=ciclo,y=paro,col=ccaa)) +
            	geom_line(size=rel(1.2)) + facet_grid(gedad ~ nforma3) +
            	scale_x_continuous(breaks=seq(142,166,4),
            							 labels= 2008:2014)+
            	scale_y_continuous(labels=percent)+
                
            	labs(x = "Years", y = "Unemployment rate in %",colour="Regions") +
            	ggtitle("Unemployment rate evolution by age and education level\n2008-2014")
            	theme(axis.text.x = element_text(angle=90, hjust=1, vjust=.5),
            			strip.text = element_text(face = "bold"),
            			legend.title = element_text(size = rel(1.2)),
            			legend.text = element_text(size = rel(1.2)))
            
            p
            
        })
        
        # Render table and download
        
        # 1 create a reactive object to allow renderTable and download table 
        
        datasetInput <- reactive({
            initciclo <- data$ciclo[data$ciclonombre==input$initperiod][1]
            endciclo <- data$ciclo[data$ciclonombre==input$endperiod][1]
            
            filtro <- data$nforma3== forma.sel() & data$ccaa==input$ccaa3 &
                data$ciclo >= initciclo & data$ciclo <= endciclo
            tmp <- data[filtro, ]
            tmp$ciclonombre <- droplevels(tmp$ciclonombre)
            
            tabla <- with(tmp, xtabs(100*paro ~  ciclonombre + gedad))
            tabla 
        })
        
        # 2 render table using reactive object
        output$tabla <- renderTable({datasetInput()})
        
        # 3 Use downloadHandler to be made available download table.
        # note the use of reactive object datasetInput in content part of function
        
        output$downloadData <- downloadHandler(filename = function(){
            paste('resultado','.csv',sep='')},
                                               content = function(file) {
                                                   write.csv(datasetInput(), file) 
                                                   })


})