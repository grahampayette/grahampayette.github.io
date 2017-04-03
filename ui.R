# UI.R
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

library(shiny)
library(leaflet, warn.conflicts = FALSE, quietly = TRUE, verbose = FALSE)
# Define UI for application that draws a map
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Find the highest rated walk-in clinics close to you"),
  
  # Sidebar with a slider input for number of clinic stars 1-5  
  sidebarLayout(
    sidebarPanel(
       sliderInput("Stars",
                   "Choose the clinic star rating (1-5)",
                   min = 1,
                   max = 5,
                   value = 5)
    ),
    
    # Show a Map of clinics generated with Leaflet
    mainPanel(leafletOutput("myMap"))
  )
))
