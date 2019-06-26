library(rsconnect)
library(downloader)
library(NCmisc)

shinyServer(function(input, output) {
  
  # First remove any server or ui files that exist on server
  file.remove("to_deploy/ui.R")
  file.remove("to_deploy/server.R")
  

  observeEvent(input$deploy,{
    
    browser()
    # Download server and ui files
    download(input$ui,
             destfile = "to_deploy/ui.R")
    download(input$server,
             destfile = "to_deploy/server.R")
    
    # Might have to figure out and install relevant packages
    ui_packages <- list.functions.in.file("to_deploy/ui.R", alphabetic = TRUE)
    server_packages <- list.functions.in.file("to_deploy/server.R", alphabetic = TRUE)
    packages <- c(names(ui_packages),names(server_packages))[grep("package", c(names(ui_packages),names(server_packages)))]
    packages <- substr(packages, 9, 100)
    packages <- packages[-which(packages == "base")]
    
    # Define shiny app account
    shiny_inputs <- list(name=input$account, 
     token=input$token, 
     secret=input$secret)
  
    rsconnect::setAccountInfo(shiny_inputs[[1]],
                                     shiny_inputs[[2]],
                                     shiny_inputs[[3]])
    
    deployApp(appDir = "to_deploy",
              appName = input$app_name,
              account = input$account)
  })
  

  
})
