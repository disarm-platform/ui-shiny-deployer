library(rsconnect)
library(downloader)
library(NCmisc)

shinyServer(function(input, output) {
  
  # First remove any server or ui files that exist on server
  file.remove("to_deploy/ui.R")
  file.remove("to_deploy/server.R")
  
  # get all files in the directories, recursively
  f <- list.files("to_deploy", include.dirs = F, full.names = T, recursive = T)
  # remove the files
  file.remove(f)
  

  observeEvent(input$deploy,{
    
    withProgress(message = 'Deploying your app',{
    
    # Download server and ui files
    download(input$ui,
             destfile = "to_deploy/ui.R")
    download(input$server,
             destfile = "to_deploy/server.R")
    
    # Define shiny app account
    # shiny_inputs <- list(name=input$account, 
    #  token=input$token, 
    #  secret=input$secret)
  
    rsconnect::setAccountInfo(input$account,
                              token=input$token,
                              input$secret)
    
    deployApp(appDir = "to_deploy",
              appName = input$app_name,
              account = input$account)
    
    })
    
    showNotification("App deployed at", paste0(input$account,
                                               ".shinyapps.io",
                                               "/",input$app_name))
  })
  

  
})
