library(shiny)

source('./code/core.R')

shinyServer(
    
    function(input, output) {
        # -- Checking --  
        output$error <- renderText({ 
            year <- input$year
            type <- input$type
            submit <- input$submit
            getMessage(year, type, submit)
        })
        
        
        # -- Graph --  
        output$result <- renderPlot({ 
            if (input$type == "-" || length(input$year) == 0 || input$submit == 0){
                return()
            } else {
                isolate({
                    year <- input$year
                    type <- input$type
                    getResult(year, type)
                })
            }
        })
        
        # -- Map --
        output$map <- renderPlot({
            if (input$type == "-" || length(input$year) == 0 || input$submit == 0){
                return()
            } else {
                isolate({
                    year <- input$year
                    type <- input$type
                    getMap(year, type)
                })
            }
        })
        
        # -- Summary of the data --
        output$summary <- renderPrint({
            if (input$type == "-" || length(input$year) == 0 || input$submit == 0){
                return()
            } else {
                isolate({
                    year <- input$year
                    type <- input$type
                    getSummary(year, type)
                })
            }
        })
        
        # -- Table view of the data --
        output$table <- renderTable({
            if (input$type == "-" || length(input$year) == 0 || input$submit == 0){
                return()
            } else {
                isolate({
                    year <- input$year
                    type <- input$type
                    getData(year, type)
                })
            }
        })
    })
