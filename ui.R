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
                  textInput("repo", "Repository name", placeholder = "e.g. ui-village-finder"),
                  textInput("algo", "Algorithm URL", placeholder = "Not needed right now.."),
                  textInput("app_name", "App name"),
                  textInput("account", "Shinyapps Tokens", placeholder = "Hint: starts with 'rsconnect::setAccountInfo' "),
                  actionButton("deploy", "Deploy app")
                  )
                ))
)
