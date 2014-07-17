library(shiny)
library(ggplot2)
library(scales)
# library(bitops)
# library(httpuv)
library(reshape2)
# suppressPackageStartupMessages(library(googleVis))

load("data.rda")


shinyServer(function(input, output) {
        
        #creates reactive formula for the input variable
        ccaa.sel <- reactive({
            c("Total",input$ccaa1, input$ccaa2)
        })
        
        
        edad.sel <- reactive({
            input$gedad
        })
        
        forma.sel <- reactive({
            input$nforma
        })
        
        auxi <- reactive({
            sel <- data$ccaa %in% ccaa.sel()
            auxi <- data[sel,]            
        })

        
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
        output$tabla <- renderTable({
             initciclo <- data$ciclo[data$ciclonombre==input$initperiod][1]
             endciclo <- data$ciclo[data$ciclonombre==input$endperiod][1]

             filtro <- data$nforma3== forma.sel() & data$ccaa==input$ccaa3 &
                 data$ciclo >= initciclo & data$ciclo <= endciclo
             tmp <- data[filtro, ]
             tmp$ciclonombre <- droplevels(tmp$ciclonombre)
             
            tabla <- with(tmp, xtabs(100*paro ~  ciclonombre + gedad))
#             colnames(tabla) <- c("Period","Unemployment rate %")
            tabla
                         
            
        })

# previous plots

#         output$plot1 <- renderPlot({
#             sel <- data$ccaa %in% ccaa.sel()
#             edad <- epa2008_2014$gedad== edad.sel()
#             forma <- epa2008_2014$nforma3 == forma.sel()
#             auxi <- data[sel & edad & forma, ] 
#             p <- ggplot(auxi, aes(x=ciclo,y=paro,col=ccaa)) +
#                 geom_line()
#          
#                 print(p)
#         })

#       output$plot1 <- renderGvis({
#           sel <- data$ccaa %in% ccaa.sel()
#           edad <- epa2008_2014$gedad== edad.sel()
#           forma <- epa2008_2014$nforma3 == forma.sel()
#           auxi <- data[sel & edad & forma, ]
#           auxi <- auxi[,c("ciclo","ccaa","paro")]
#           auxi.melt <- melt(auxi, id.vars=c("ciclo","ccaa"), meausure.vars="paro" )
#           auxi.cast <- dcast(auxi.melt, variable + ciclo ~ ccaa, mean)
#           gvisLineChart(auxi.cast,xvar="ciclo",yvar=ccaa.sel(),
#               options=list(width=400, height=300) )
#     
#     
# })
})