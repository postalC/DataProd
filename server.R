library(shiny)

source('./code/core.R')

shinyServer(
  
  function(input, output) {
      # -- Checking --  
      output$error <- renderText({ 
          if (length(input$year) == 0){
              "Year is not selected..."
          } else
          if (input$type == "-"){
              "Type is not selected..."
          }
      })
      
    # -- Graph --  
    output$result <- renderPlot({ 
        if (input$type == "-" ){
        } else {
            year <- input$year
            type <- input$type
            getResult(year, type)
        }
    })
    
    # -- Map --
    output$map <- renderPlot({
        if (input$type == "-"){
        } else {
            year <- input$year
            type <- input$type
            getMap(year) 
        }
    })    
})
