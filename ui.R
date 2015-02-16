library(shiny)

# -- Ui.R --
shinyUI(fluidPage(  
    # -- Title --
    titlePanel("Singapore International Visitor"),  
    
    # -- Sidebar --
    sidebarLayout(
        # -- SidePanel --    
        absolutePanel(
            top = 5, left = 5, width = 485,
            draggable = TRUE,
            # -- Singapore Merlion Image --
            img(src = "icon.jpg", height = 348, width = 468),      
            
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
            # -- Help Message --
            helpText("The process would took", code("30~40 seconds")," to generate on the first run..."),
            # -- Error Message -
            h4(textOutput('error')),
            # -- Submit Button --
            actionButton("submit", code("--> generate @_@ -->"))
        ),
        
        # -- Main Panel --
        absolutePanel(
            top = 5, left = 490, width = 1000,
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
                         h5("-", code('0.Data'), "show the information about the data,"),
                         h5("-", code("1.Summary"), "tab to check the data summary,"),
                         h5("-", code("2.Data"), "tab to check the data info,"),
                         h5("-", code('3.Graph'), "show the visitors changes accross selected year(s),"),
                         h5("-", code('4.Map'), "show the geo-location of the visitors from and thier numbers."),
                         br(),
                         # -- Steps --
                         h4("How it works: "),
                         h5("You may find the report options on the left sidebar:"),
                         h5("1. Select the year(s) by checking the checkbox below, multiple selection is allowed;"),
                         h5("2. Select the type of report - Number of Visitor(y axis) by Region or Countries(x axis);"),
                         h5("3. Click the ", code("--> generate @_@ -->"), "button to generate the report,"),
                         h5("4. Click the ", code("1.Summary"), "tab to check data summary,"),
                         h5("5. Click the ", code("2.Data"), "tab to check the data,"),
                         h5("6. Click the ", code("3.Graph"), "tab to check the plot info,"),
                         h5("7. Click the ", code("4.Map"), "tab to check the map info,"),
                         h5("8. Or repeat steps 1-2 with different combination to generate different report.")
                     ),  
                ## -- Info Tab
                tabPanel("0.Source",
                         # -- About Singapore --
                         h3("Singapore", a("Wikipedia", 
                                           href = "http://en.wikipedia.org/wiki/Singapore")),   
                         # -- Singapre Map --
                         img(src = "map.jpg", height = 187, width = 269), 
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
                tabPanel("1.Summary", h3(textOutput('summaryMessage')), verbatimTextOutput("summary")),
                tabPanel("2.Data", h3(textOutput('tableMessage')), tableOutput("table")),
                tabPanel("3.Graph", h3(textOutput('resultMessage')), plotOutput("result", height = 750, width = 1200)),
                tabPanel("4.Map", h3(textOutput('mapMessage')), plotOutput("map", height = 700, width = 1200))
            )
        )
    )
))
