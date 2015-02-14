library(ggplot2)
library(pxR)
library(ggmap)
library(maptools)
library(maps)

## -- Read Visitors Data --
dataFile <- "./data/iva.csv"
## -- To avoid delay, the data is preprocessed --
data <- data.frame(read.csv(dataFile))
data$Country <- factor(data$Country, levels = unique(data$Country), ordered = TRUE)
data$Region <- factor(data$Region, levels = unique(data$Region), ordered = TRUE)
data$Visitors <- data$Visitors/1000
data$Year <- as.factor(data$Year)
## -- Load Countries Geo Lat/Long data, to avoid delay --
geoFile <- "./data/latlong.csv"
geo <- data.frame(read.csv(geoFile))

## -- Get Message - for speed for process --
getMessage <- function(year, type, submit) {
    if (length(year) == 0){
        "Year is not selected..."
    } else if (type == "-"){
        "Type is not selected..."
    } else if (submit == 0) {
        "Please click on button '--> generate @_@ -->' to proceed..."
    } else {
        "Running... please check the result at [Graph|Map|Summary|Data] tab... :)"
    }
}

## -- Get Plot --
getResult <- function(year, type) {
    if(length(year) == 0 || type == "-"){
        return()
    }
    pData <- data
    pData <- subset(data, pData$Year %in% year)
    if (type == "All"){
        p1 <- ggplot(data = pData, aes(x=Country, y=Visitors))
        p1 + geom_line(aes(colour = Year, group = Year), size = 2) +
            xlab("Countries (Order by Region)") +
            ylab("Total Number of Visitor (Thursands)") +
            ggtitle("Number of travellers visiting Singapore and their Country of Residence") +
            theme(plot.title = element_text(size = 20)) +
            theme(axis.text.x = element_text(angle = 90, vjust = 1)) 
    } else {
        pData <- subset(data, pData$Region == type)
        pR <- ggplot(data = pData, aes(x=Country, y=Visitors))
        pR + geom_line(aes(colour = factor(Year), group = Year), size = 2) +
            xlab("Regions") +
            ylab("Total Number of Visitors (Thursands)") +
            ggtitle("Number of travellers visiting Singapore and their Region") +
            theme(plot.title = element_text(size = 20)) +
            theme(axis.text.x = element_text(angle = 90, vjust = 1))   
    }
}

# -- Create Map --
getMap <- function(year, type) {
    if(length(year) == 0 || type == "-"){
        return()
    }
    pData <- data
    pData <- subset(pData, pData$Year %in% year)
    if (type != "All"){
        pData <- subset(data, pData$Region == type)       
    }
    pGeo <- geo
    pGeo <- subset(pGeo, pGeo$Country %in% pData$Country)
    ## -- Sum the number of visitors --
    sumV <- aggregate(pData$Visitors, by=list(Country=pData$Country), FUN=sum)
    pGeo <- merge( geo, sumV, by='Country', all.geo = T, sort=F )
    colnames(pGeo)[4] <- "Totals"
    ## -- Point Size --
    if (type == "All"){
        pGeo$Total <- pGeo$Total/(1000*length(unique(pData$Year)))
    } else if  (type == "AMERICAS"){
        pGeo$Total <- pGeo$Total/(50*length(unique(pData$Year)))
    } else if  (type == "ASIA (SouthEast)"){
        pGeo$Total <- pGeo$Total/(500*length(unique(pData$Year)))    
    } else if  (type == "ASIA (North)"){
        pGeo$Total <- pGeo$Total/(300*length(unique(pData$Year)))
    } else if  (type == "ASIA (South)"){
        pGeo$Total <- pGeo$Total/(150*length(unique(pData$Year)))          
    } else if  (type == "ASIA(West)"){
        pGeo$Total <- pGeo$Total/(10*length(unique(pData$Year)))         
    } else if  (type == "EUROPE"){
        pGeo$Total <- pGeo$Total/(50*length(unique(pData$Year)))   
    } else if  (type == "OCEANIA"){
        pGeo$Total <- pGeo$Total/(100*length(unique(pData$Year)))  
    } else if  (type == "AFRICA"){
        pGeo$Total <- pGeo$Total/(10*length(unique(pData$Year)))
    }
    ## Plot Map --
    map(database="world", regions=".", fill=TRUE, col="white", bg="lightblue", ylim=c(-60, 90), mar=c(0,0,0,0))
    points(pGeo$Lon,pGeo$Lat, col=heat.colors(200), pch=16, cex = pGeo$Total)
}

# -- Return Summary --
getSummary <- function(year, type) {
    if(length(year) == 0 || type == "-"){
        return()
    }
    pData <- data
    pData <- subset(data, pData$Year %in% year)
    if (type != "All"){
        pData <- subset(data, pData$Region == type)
    }
    summary(pData)
}

# -- Return Data --
getData <- function(year, type) {
    if(length(year) == 0 || type == "-"){
        return()
    }
    pData <- data
    pData <- subset(data, pData$Year %in% year)
    if (type != "All"){
        pData <- subset(data, pData$Region == type)
    }
    return(pData)
}

