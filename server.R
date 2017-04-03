# Server.R
# Graham Payette
# Developing Data Products - Week 4 Project
# April 2, 2017
#
# Simple application demonstrating the use of Leaflet
# and Shiny.  
# Dataset with fictitious rankings of walk-in clinics across
# Vancouver Island.
#
# Potential Application is for people looking for a walk-in clinic
# in close proximity to their location.  They can see the address and
# ranking. 
# The server takes the rating number from the UI loads and filters the 
# data set based on the rating and returns a leaflet map for rendering
# in the UI.

library(shiny)
library(leaflet)

# Define server logic required to draw a leaflet map
shinyServer(function(input, output) {
   
  df <- read.csv(file = "https://grahampayette.github.io/clinics.csv", header = TRUE, sep = ",")
  
# Key here is to realize that reactive returns a function. Needed to reference function and not variable name to make leaflet call work  
# Reactive statement uses the star rating input to filter the original data file.
    ff <- reactive({subset(df, df$Rating == input$Stars)})

    output$myMap <- renderLeaflet({ff() %>% leaflet() %>% addTiles() %>% addMarkers(lat = ff()$LAT, lng = ff()$LONG, popup = ~as.character(ff()$ADDR), label = paste("Rating - ", ff()$Rating), clusterOptions = markerClusterOptions()) %>% addLegend(labels = "", title = "Walk-In Clinics", colors= "")})
    
  })
  

