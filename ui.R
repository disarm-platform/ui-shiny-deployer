library(shinydashboard)

dashboardPage(
  dashboardHeader(),
  dashboardSidebar(disable = F),
  dashboardBody(#useShinyjs(),
                
                fluidRow(
                  #includeCSS("styles.css"),
                  box(
                    
                  p("This app allows you to deploy existing shiny app source code. All you need 
                  is a shinyapps account and links to the ui.R and server.R scripts"),
                  textInput("ui", "Link to ui.R"),
                  textInput("server", "Link to server.R"),
                  textInput("algo", "Algorithm URL", placeholder = "Not needed right now.."),
                  textInput("app_name", "App name"),
                  textInput("account", "shinyapps account"),
                  textInput("token", "shinyapps token"),
                  textInput("secret", "shinyapps secret"),
                  actionButton("deploy", "Deploy app")
                  )
                ))
)
