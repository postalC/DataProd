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
                        label = "Plot by All Countries or Specify Region:",
                        choices = c("Not selected"= "-",
                                    "All Countries" = "All",
                                    "Region - Americas" = "AMERICAS",
                                    "Region - South East Asia" = "ASIA (SouthEast)",
                                    "Region - North Asia" = "ASIA (North)",
                                    "Region - South Asia"= "ASIA (South)",
                                    "Region - West Asia" = "ASIA(West)",
                                    "Region - Europe" = "EUROPE",
                                    "Region - Oceania" = "OCEANIA",
                                    "Region - Africa" = "AFRICA"),
                        selected = "-"),
            # -- Submit Button --
            actionButton("submit", code("--> generate @_@ -->")),
            br(),
            # -- Error Message -
            h4('Application Message: '),
            textOutput('error')
        ),
        
        # -- Main Panel --
        absolutePanel(
            top = 0, left = 490, width = 1000,
            draggable = TRUE,

            tabsetPanel(
                ## -- Info Tab
                tabPanel("Info",
                         # -- Desc -- 
                         h3("Project Info"),
                         h5("This report shows the total number of visitor arrivals from the world to 
                            Singapore for the range of year(s) selected and their country/region."),
                         br(),
                         ## -- What --
                         h4("What report generatad: "),
                         h5("You may found the generated reports/details on tab-panel:"),
                         h5("-", code('Data'), "show the information about the data,"),
                         h5("-", code('Graph'), "show the visitors changes accross selected year(s),"),
                         h5("-", code('Map'), "show the geo-location of the visitors from and thier numbers."),
                         h5("-", code("Summary"), "tab to check the data summary,"),
                         h5("-", code("Data"), "tab to check the data info,"),
                         br(),
                         # -- Steps --
                         h4("How it works: "),
                         h5("You may find the report options on the left sidebar:"),
                         h5("1. Select the year(s) by checking the checkbox below, multiple selection is allowed;"),
                         h5("2. Select the type of report - Number of Visitor(y axis) by Region or Countries(x axis);"),
                         h5("3. Click the ", code("--> generate @_@ -->"), "button to generate the report,"),
                         h5("4. Click the ", code("Graph"), "tab to check the plot info,"),
                         h5("5. Click the ", code("Map"), "tab to check the map info,"),
                         h5("6. Click the ", code("Summary"), "tab to check data summary,"),
                         h5("7. Click the ", code("Data"), "tab to check the data,"),
                         h5("8. Or repeat steps 1-2 with different combination to generate different report."),
                         br(),
                         h4("The process would took few seconds to generate on the first run, thank you for your understanding and patience.")
                         ),  
                ## -- Info Tab
                tabPanel("Source",
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
                        Embarkation (D/E) Cards by the Immigration and Checkpoints Authority of Singapore."),
                         br(),
                         h4("Github Report URL: ",
                            a("Data Produt Project", 
                              href = "https://github.com/postalC/DataProd"))
                         ),
                tabPanel("Graph",plotOutput("result", height = 750, width = 1200)),
                tabPanel("Map",plotOutput("map", height = 600, width = 1000)),
                tabPanel("Summary", verbatimTextOutput("summary")),
                tabPanel("Data", tableOutput("table"))
            )
        )
    )
))
