
library(shiny)
library(leaflet)
library(dplyr)
library(tidyr)
library(sf)


data1 <- st_read("~/Desktop/shiny app/MBTA_Systemwide_GTFS_Map (1).geojson")


ui <- fluidPage(
  selectInput("route_id", "route_id:", choices = unique(data1$route_id)
  ),
  leafletOutput("map", width = "100%", height = "800px"))


server <- function(input, output) {
  # Create a leaflet map
  output$map <- renderLeaflet({
    
    # Filter the data by the selected line
    filtered_data <- data1 %>%
      filter(route_id == input$route_id)
    
    leaflet(filtered_data[,"geometry"]) %>%
    addTiles() %>%  
    addPolylines(color = "green", weight = 6)
  }
  )
}


shinyApp(ui = ui, server = server)



