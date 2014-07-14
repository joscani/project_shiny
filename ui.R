library(shiny)
library(ggplot2)

load("data.rda")
nccaa <- levels(data$ccaa)
ngedad <- levels(data$gedad)
nnforma <- levels(data$nforma3)
nperiod <- levels(data$ciclonombre)
shinyUI(fluidPage(
        sidebarLayout(position = "right",
                        sidebarPanel( "Choose 2 regions ",
                            selectInput('ccaa1', 'Region 1: ', nccaa),
                        	selectInput('ccaa2','Region 2: ', nccaa, selected="Total")
#                             selectInput('gedad',label='Age: ',ngedad),
#                             selectInput('nforma',label="Study level: ", nnforma)
                        ),
                        mainPanel(
                                h2("Comparing Unemployment rate between Spanish Regions "),  
#                                   plotOutput('plot1'),
#                                 htmlOutput("plot1"),
                                plotOutput('plot2')
                        )

        )
,
sidebarLayout(position = "right",
              sidebarPanel( "Choose a profile ",
                            selectInput('ccaa3','Region: ', nccaa, selected="Total"),
                            selectInput('nforma',label="Education level: ", nnforma),
#                             selectInput('gedad',label='Age: ',ngedad),
                            selectInput('initperiod', label = 'Choose initial period', choices = nperiod, selected = nperiod[21] ),
                            selectInput('endperiod', label = 'Choose initial period', choices = nperiod, selected = nperiod[25] )

              ),
              mainPanel(

                  h2("Unemployment rate (%) "),
                  tableOutput('tabla'),
                  h3("Explanation")  
                  
              ))))
              
