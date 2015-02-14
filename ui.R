library(shiny)

# -- Ui.R --
shinyUI(fluidPage(  
  # -- Title --
  titlePanel("Singapore International Visitor"),  
  
  # -- Sidebar --
  sidebarLayout(
      # -- SidePanel --    
      absolutePanel(
          top = 0, left = 5, width = 485,
          draggable = TRUE,
        # -- Singapore Merlion Image --
        img(src = "ML.jpg", height = 348, width = 468),      
      
        # -- Help Desc --          
        helpText("This report shows the total number of visitor arrivals from the world to 
            Singapore by specifiying years, areas and countries."),
        br(),
      
        # -- Year Input --
        checkboxGroupInput(inputId="year",  
                           label="Select years:",
                           choices=list("2011" = "2011",
                                        "2012" = "2012",
                                        "2013" = "2013",
                                        "2014" = "2014"),
                           selected=list()
        ),
        # -- Plot Type Input --
        selectInput(inputId = "type",
                  label = "Plot by Region or Countries:",
                  choices = c("Not selected"= "-",
                              "Countries" = "C",
                              "Region" = "R"),
                  selected = "-"),
        # -- Submit Button --
        actionButton("submit", "proceed"),
        # -- Error Message -
        textOutput('error')
    ),
    
    # -- Main Panel --
    absolutePanel(
        top = 0, left = 490, width = 1000,
        draggable = TRUE,
        tabsetPanel(
            tabPanel("Graph",plotOutput("result", height = 800, width = 1200)),
            tabPanel("Map",plotOutput("map", height = 800, width = 1200)),
            tabPanel("About",
                     # -- About Singapore --
                     h3("Singapore", a("Wikipedia", 
                                       href = "http://en.wikipedia.org/wiki/Singapore")),   
                     # -- Data Source --
                     h4("Data obtained from: ",
                       a("Singapore Tourism Board", 
                         href = "https://www.stb.gov.sg/statistics-and-market-insights/Pages/statistics-visitor-arrivals.aspx")),
                     # -- Some Details --
                     h5("International Visitor Arrivals refer to travellers taking a trip to Singapore whose length of stay is less than a year."),
                     h5("This excludes: "),
                     p("- All Malaysian citizens arriving by land;"),
                     p("- Returning Singapore citizens, permanent residents and pass holders;"),
                     p("- Non-resident air and sea crew (except for sea crew flying in to join a ship); and"),
                     p("- Air transit and transfer passengers."),
                     br(),
                     p("Arrival statistics are reported by country of residence based on information from Disembarkation/ 
                        Embarkation (D/E) Cards by the Immigration and Checkpoints Authority of Singapore.")
                     )
                    )
    )
  )
))
