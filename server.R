library(shiny)

source('./code/core.R')

shinyServer(
    
    function(input, output) {
        # -- Checking --  
        output$error <- renderText({ 
            year <- input$year
            type <- input$type
            submit <- input$submit
            getResult(c("2014"), "All")
            getMap(c("2014"), "All")
            getMessage(year, type, submit)
        })
        
        
        # -- Graph --  
        output$result <- renderPlot({ 
            if (input$type == "-" || length(input$year) == 0 || input$submit == 0){
                return()
            } else {
                isolate({
                    withProgress(message = 'Creating plot ....', value = 0.05, {
                        Sys.sleep(0.25)
                        # Create 0-row data frame which will be used to store data
                        dat <- data.frame(x = numeric(0), y = numeric(0))
                        # withProgress calls can be nested, in which case the nested text appears
                        # below, and a second bar is shown.
                        withProgress(message = 'Processing data --> ', detail = "0%", value = 0, {
                            for (i in 1:50) {
                                # Each time through the loop, add another row of data. This a stand-in
                                # for a long-running computation.
                                dat <- rbind(dat, data.frame(x = rnorm(1), y = rnorm(1)))
                                # Increment the progress bar, and update the detail text.
                                i<- i*2
                                incProgress(0.1, detail = paste(i, "%"))
                                # Pause for 0.1 seconds to simulate a long computation.
                                Sys.sleep(0.1)
                            }
                        })
                        # Increment the top-level progress indicator
                        incProgress(0.5)
                        
                        # Another nested progress indicator.
                        # When value=NULL, progress text is displayed, but not a progress bar.
                        withProgress(message = 'Finaling', detail = "100% DONE",
                                     value = NULL, {
                                         Sys.sleep(0.75)
                                     })
                        # We could also increment the progress indicator like so:
                        # incProgress(0.5)
                        # but it's also possible to set the progress bar value directly to a
                        # specific value:
                        setProgress(1)
                    })
                    
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
                    withProgress(message = 'Creating map ....', value = 0.1, {
                        Sys.sleep(0.25)
                        # Create 0-row data frame which will be used to store data
                        dat <- data.frame(x = numeric(0), y = numeric(0))
                        # withProgress calls can be nested, in which case the nested text appears
                        # below, and a second bar is shown.
                        withProgress(message = 'Processing data --> ', detail = "0%", value = 0, {
                            for (i in 1:50) {
                                # Each time through the loop, add another row of data. This a stand-in
                                # for a long-running computation.
                                dat <- rbind(dat, data.frame(x = rnorm(1), y = rnorm(1)))
                                # Increment the progress bar, and update the detail text.
                                i<- i*2
                                incProgress(0.1, detail = paste(i, "%"))
                                # Pause for 0.1 seconds to simulate a long computation.
                                Sys.sleep(0.1)
                            }
                        })
                        # Increment the top-level progress indicator
                        incProgress(0.5)
                        
                        # Another nested progress indicator.
                        # When value=NULL, progress text is displayed, but not a progress bar.
                        withProgress(message = 'Finaling', detail = "100% DONE",
                                     value = NULL, {
                                         Sys.sleep(0.75)
                                     })
                        # We could also increment the progress indicator like so:
                        # incProgress(0.5)
                        # but it's also possible to set the progress bar value directly to a
                        # specific value:
                        setProgress(1)
                    })
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
                    withProgress(message = 'Creating summary ....', value = 0.1, {
                        Sys.sleep(0.25)
                        # Create 0-row data frame which will be used to store data
                        dat <- data.frame(x = numeric(0), y = numeric(0))
                        # withProgress calls can be nested, in which case the nested text appears
                        # below, and a second bar is shown.
                        withProgress(message = 'Processing data --> ', detail = "0%", value = 0, {
                            for (i in 1:10) {
                                # Each time through the loop, add another row of data. This a stand-in
                                # for a long-running computation.
                                dat <- rbind(dat, data.frame(x = rnorm(1), y = rnorm(1)))
                                # Increment the progress bar, and update the detail text.
                                i<- i*10
                                incProgress(0.1, detail = paste(i, "%"))
                                # Pause for 0.1 seconds to simulate a long computation.
                                Sys.sleep(0.1)
                            }
                        })
                        # Increment the top-level progress indicator
                        incProgress(0.5)
                        # Another nested progress indicator.
                        # When value=NULL, progress text is displayed, but not a progress bar.
                        withProgress(message = 'Finaling', detail = "100% DONE",
                                     value = NULL, {
                                         Sys.sleep(0.75)
                                     })
                        # We could also increment the progress indicator like so:
                        # incProgress(0.5)
                        # but it's also possible to set the progress bar value directly to a
                        # specific value:
                        setProgress(1)
                    })
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
                    withProgress(message = 'Creating table ....', value = 0.1, {
                        Sys.sleep(0.25)
                        # Create 0-row data frame which will be used to store data
                        dat <- data.frame(x = numeric(0), y = numeric(0))
                        # withProgress calls can be nested, in which case the nested text appears
                        # below, and a second bar is shown.
                        withProgress(message = 'Processing data --> ', detail = "0%", value = 0, {
                            for (i in 1:10) {
                                # Each time through the loop, add another row of data. This a stand-in
                                # for a long-running computation.
                                dat <- rbind(dat, data.frame(x = rnorm(1), y = rnorm(1)))
                                # Increment the progress bar, and update the detail text.
                                i<- i*10
                                incProgress(0.1, detail = paste(i, "%"))
                                # Pause for 0.1 seconds to simulate a long computation.
                                Sys.sleep(0.1)
                            }
                        })
                        # Increment the top-level progress indicator
                        incProgress(0.5)
                        # Another nested progress indicator.
                        # When value=NULL, progress text is displayed, but not a progress bar.
                        withProgress(message = 'Finaling', detail = "100% DONE",
                                     value = NULL, {
                                         Sys.sleep(0.75)
                                     })
                        # We could also increment the progress indicator like so:
                        # incProgress(0.5)
                        # but it's also possible to set the progress bar value directly to a
                        # specific value:
                        setProgress(1)
                    })                    
                    year <- input$year
                    type <- input$type
                    getData(year, type)
                })
            }
        })
    })
