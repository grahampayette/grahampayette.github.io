---
title       : Week4 Project Developing Data Products
subtitle    : Slide 1
author      : Graham Payette
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Welcome to the Pitch - Slide 2

The Shiny App for this project will definitely add years to your life.  No more fretting about finding decent medical care.  When in need, just access this app to find the highest rated medical clinic close to you. 

You can try the app on the next slide. Note - if you can't navigate to the next slide after using the app - click on the slide title to regain focus and then navigate as normal.

--- .class #id 

## Slide 3

<iframe src="https://gpayette.shinyapps.io/Week4/"></iframe>

---

## Slide 4
This is the UI source code for the preceding slide:
```r
lirary(shiny)
library(leaflet, warn.conflicts = FALSE, quietly = TRUE, verbose = FALSE)
# Define UI for application that draws a map
shinyUI(fluidPage(  titlePanel("Find the highest rated walk-in clinics close to you"),
  # Sidebar with a slider input for number of clinic stars 1-5  
  sidebarLayout(
    sidebarPanel(
       sliderInput("Stars",
                   "Choose the clinic star rating (1-5)",
                   min = 1,max = 5,value = 5)
    ),
     # Show a Map of clinics generated with Leaflet
    mainPanel(leafletOutput("myMap"))
  )
))
```

---

## Slide 5
This is the server.r source code for the app
```r
library(shiny)
library(leaflet)

# Define server logic required to draw a leaflet map
shinyServer(function(input, output) {
  df <- read.csv(file = "the data file",  header = TRUE, sep = ",")
# Key here is to realize that reactive returns a function. 
# Reactive statement uses the star rating input to filter the original data file.
    ff <- reactive({subset(df, df$Rating == input$Stars)})
    output$myMap <- renderLeaflet({ff() %>% leaflet() %>% addTiles() %>%
    addMarkers(lat = ff()$LAT, lng = ff()$LONG, popup = ~as.character(ff()$ADDR),
    label = paste("Rating - ", ff()$Rating), clusterOptions = markerClusterOptions()) 
    %>% addLegend(labels = "", title = "Walk-In Clinics", colors= "")})
  })

```









