library(rsconnect)
library(downloader)
library(NCmisc)
library(stringr)

shinyServer(function(input, output) {
  
  # First remove any server or ui files that exist on server
  f <- list.files("to_deploy", include.dirs = T, full.names = T, recursive = T)
  # remove the files
  file.remove(f)
  
  observeEvent(input$deploy,{
    
    withProgress(message = 'Deploying your app',{

    # Get repo files
    repo <- paste0("https://raw.githubusercontent.com/disarm-platform/", input$repo, "/master/")
    
    # Download server and ui files
    download(paste0(repo, "ui.R"),
             destfile = "to_deploy/ui.R")
    download(paste0(repo, "server.R"),
             destfile = "to_deploy/server.R")
    
    # Download utils.R if it exists
    try({
      download(paste0(repo, "utils.R"), destfile = "to_deploy/utils.R")},
      silent = TRUE)
    
    # Download css file if exists
    try({
      download(paste0(repo, "styles.css"), destfile = "to_deploy/styles.css")},
        silent = TRUE)
    
    commas <- str_locate_all(input$account, "'")[[1]][,1]
    account <- substr(input$account, commas[1]+1, commas[2]-1)
    token <- substr(input$account, commas[3]+1, commas[4]-1)
    secret <- substr(input$account, commas[5]+1, commas[6]-1)
    
    rsconnect::setAccountInfo(account,
                              token,
                              secret)
    
    deployApp(appDir = "to_deploy",
              appName = input$app_name,
              account = account)
    
    })
    
    showNotification("App deployed at", paste0(input$account,
                                               ".shinyapps.io",
                                               "/",input$app_name))
  })
  

  
})
