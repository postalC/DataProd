library(ggplot2)
library(pxR)
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
        "Type (Contries/Region) is not selected..."
    } else if (submit == 0) {
        "Please click on button '--> generate @_@ -->' to proceed..."
    } else {
        "Completed... :)"
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
            ylab("Total Number of Travellers (Thursands)") +
            ggtitle("Number of travellers visited Singapore and their Country of Residence") +
            theme(plot.title = element_text(size = 20)) +
            theme(axis.text.x = element_text(angle = 90, vjust = 1)) 
    } else {
        pData <- subset(pData, pData$Region == type)
        pR <- ggplot(data = pData, aes(x=Country, y=Visitors))
        pR + geom_line(aes(colour = factor(Year), group = Year), size = 2) +
            xlab("Regions") +
            ylab("Total Number of Travellers (Thursands)") +
            ggtitle("Number of travellers visited Singapore and their Region") +
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
        pGeo$Scale <- pGeo$Totals/(100*length(unique(pData$Year)))
    } else if  (type == "AMERICAS"){
        pGeo$Scale <- pGeo$Totals/(50*length(unique(pData$Year)))
    } else if  (type == "ASIA (SouthEast)"){
        pGeo$Scale <- pGeo$Totals/(200*length(unique(pData$Year)))    
    } else if  (type == "ASIA (North)"){
        pGeo$Scale <- pGeo$Totals/(200*length(unique(pData$Year)))
    } else if  (type == "ASIA (South)"){
        pGeo$Scale <- pGeo$Totals/(150*length(unique(pData$Year)))          
    } else if  (type == "ASIA(West)"){
        pGeo$Scale <- pGeo$Totals/(10*length(unique(pData$Year)))         
    } else if  (type == "EUROPE"){
        pGeo$Scale <- pGeo$Totals/(50*length(unique(pData$Year)))   
    } else if  (type == "OCEANIA"){
        pGeo$Scale <- pGeo$Totals/(100*length(unique(pData$Year)))  
    } else if  (type == "AFRICA"){
        pGeo$Scale <- pGeo$Totals/(5*length(unique(pData$Year)))
    }
    ## Plot Map --
    world <- map_data("world")
    ggplot() +
        geom_polygon(data=world, aes(x=long, y=lat,group=group)) + 
        geom_point(data=pGeo,aes(Lon,Lat, colour=Scale),cex = pGeo$Scale) + 
        scale_colour_gradient(high = "pink", low = "red") +
        ggtitle("The Scale of Traveller by Countries") +
        theme(plot.title = element_text(lineheight=.8, face="bold")) +
        xlab("Longitude") + 
        ylab("Latitude")
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

