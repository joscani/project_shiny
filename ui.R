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

                                plotOutput('plot1'),
                                h3("Explanation"),
                                p("This app has been designed to explore unemployment rate in Spanish regions using",em("EPA"),"public microdata"),
                                p("EPA microdata has about 171000 persons each period and we calculate unemployment rate for 25 periods. Survey is made each 3 months"),

                                p("You can choose 2 differents regions and figure reacts to show unemployment rate evolution since 1T 2008 to 1T 2014. Figure include both selected regions and total. The facets indicate education level in columns and age group in rows "),
                                p("As you can see, unemployment rates are increasing since 2008 but this increasing is less for high age groups and high education levels "),
                                p("You can see how to calculate unemployment rate step by step in my",a("rpubs document", href=("http://rpubs.com/joscani/unemplrate")) ),
                                p(" "),
                                p("Below you can select a region, education level and period to see unemployment rate evolution by age groups. You also can download the data in a csv file")
                        )

        )
,
sidebarLayout(position = "right",
              sidebarPanel( "Choose a profile ",
                            selectInput('ccaa3','Region: ', nccaa, selected="Total"),
                            selectInput('nforma',label="Education level: ", nnforma),
#                             selectInput('gedad',label='Age: ',ngedad),
                            selectInput('initperiod', label = 'Choose initial period', choices = nperiod, selected = nperiod[21] ),
                            selectInput('endperiod', label = 'Choose initial period', choices = nperiod, selected = nperiod[25] ),
                            downloadButton('downloadData', 'Download')

              ),
              mainPanel(

                  h2("Unemployment rate (%) "),
                  tableOutput('tabla') 
              ))))
              
