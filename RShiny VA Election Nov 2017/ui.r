library(shiny)
library(shinythemes)
library(leaflet)
library(dplyr)
library(rmarkdown)

## Process the raw data
dataset <- read.table(paste(getwd(), "/results.txt", sep=""), header = TRUE, sep = ",", stringsAsFactors = FALSE)
dataset[is.na(dataset$total_votes),]$total_votes = 0
dataset[dataset$locality_name == "KING & QUEEN COUNTY",]$locality_name <- "KING AND QUEEN COUNTY"
locality <- distinct(dataset,locality_name)
office_name <- c("Governor", "Attorney General", "Lieutenant Governor", "Member House of Delegates")

shinyUI(
  tagList(
    navbarPage(theme = shinytheme("united"),
               
               "2017 Nov Elections in Virginia",
               
               tabPanel("Shiny App Manual",
                        tabsetPanel(
                          tabPanel("Introduction",
                                   hr(),
                                   includeMarkdown("Introduction.rmd")
                          ),
                          tabPanel("Workflow",
                                   hr(),
                                   includeMarkdown("Workflow.rmd"))
                       )
               ),
               
               tabPanel("Results",
                        sidebarPanel(
## Use radio button to select the office
                          radioButtons('Office1', 'Office:', choices = office_name),
## Use select to select the region                      
                          selectInput('County/City', 'County/City:', choices = locality, selected = "ALINGTON COUNTY")
                        ),
                        
                        mainPanel(
                          tabsetPanel(
                            tabPanel("Result",
                              h4("County/City:"),
                              textOutput("v1"),
                          
                              h4("Office:"),
                              textOutput("v2"),
                          
                              hr(),
                          
                              tableOutput("results")
                            ),
                            
                            tabPanel("Pie Chart",
                                     plotOutput("pie")
                            )
                          )
                        )
               ),
               
               tabPanel("Election Map",
                        
                        sidebarPanel(
                          radioButtons('Office2', 'Office:', choices = office_name),
                          
                          sliderInput("Color levels", "Map Color levels", min = 2, max = 9, value = 4, step = 1),
                          
                          selectInput('County/City2', 'County/City:', choices = locality, selected = "ALINGTON COUNTY")
                        ),
               
                        mainPanel(
                          tabsetPanel(
##Output the maps and scatter plots
                            tabPanel("Democratic",
                                     leafletOutput("map_d")
                            ),
                            
                            tabPanel("Republican",
                                     leafletOutput("map_r")
                            ),
                            
                            tabPanel("County Scatter",
                                     plotOutput("scatter")
                            )
                          )
                        )
               )
    )
  )
)