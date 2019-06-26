library(leaflet)
library(lubridate)
library(shinyBS)
library(shinydashboard)
# library(dashboardthemes)
library(shinyjs)

dashboardPage(
  dashboardHeader(),
  dashboardSidebar(disable = F),
  dashboardBody(#useShinyjs(),
                
                fluidRow(
                  #includeCSS("styles.css"),
                  box(
                  textInput("ui", "Link to ui.R"),
                  textInput("server", "Link to server.R"),
                  textInput("algo", "Algorithm URL"),
                  textInput("app_name", "App name"),
                  textInput("account", "shinyapps account"),
                  textInput("token", "shinyapps token"),
                  textInput("secret", "shinyapps secret"),
                  actionButton("deploy", "Deploy app")
                  )
                ))
)
