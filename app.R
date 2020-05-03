library(leaflet)
library(shiny)
library(sp)

data <- read.csv("csv/cities.csv")

data$long <- as.numeric(data$long)
data$lat <- as.numeric(data$lat)

passportIcon <- makeIcon(
  iconUrl = "https://img.icons8.com/offices/30/000000/passport.png",
  iconAnchorX = 15, iconAnchorY = 15
)

ui <- fluidPage(fillPage(tags$style(type = "text/css",
                                    "#mymap {height: 100vh !important;
                                    width: 100vw !important;
                                    margin-left: -15px; !important;}"),
                         leafletOutput("mymap", width = "100%",height = "100%")))

server <- function(input, output) {
  output$mymap <- renderLeaflet({ leaflet() %>%
      addTiles() %>%
      addMarkers(data = data, lng = ~long, lat = ~lat,icon = passportIcon, popup = ~paste("<b>City</b>", data$city, "<br>",
                                                                                          "<b>Country:</b>", data$country, "<br>")) %>%
      addProviderTiles(providers$Esri.NatGeoWorldMap)
    
  })
}

shinyApp(ui, server)