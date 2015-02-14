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

## -- Get Plot --
getResult <- function(year, type) {
    pData <- data
    pData <- subset(data, pData$Year %in% year)
    if (type == "C"){
        p1 <- ggplot(data = pData, aes(x=Country, y=Visitors))
        p1 + geom_line(aes(colour = Year, group = Year), size = 2) +
            xlab("Countries (Order by Region)") +
            ylab("Total Number of Visitor (Thursands)") +
            ggtitle("Number of travellers visiting Singapore and their Country of Residence") +
            theme(plot.title = element_text(size = 20)) +
            theme(axis.text.x = element_text(angle = 90, vjust = 1)) 
    } else {
        pR <- ggplot(data = pData, aes(x=Region, y=Visitors))
        pR + geom_line(aes(colour = factor(Year), group = Year), size = 2) +
            xlab("Regions") +
            ylab("Total Number of Visitors (Thursands)") +
            ggtitle("Number of travellers visiting Singapore and their Region") +
            theme(plot.title = element_text(size = 20)) +
            theme(axis.text.x = element_text(angle = 90, vjust = 1))   
    }
}

getMap <- function(year) {
    pData <- data
    pData <- subset(pData, pData$Year %in% year)
    pGeo <- geo
    pGeo <- subset(pGeo, pGeo$Country %in% pData$Country)
    ## -- Sum the number of visitors --
    sumV <- aggregate(pData$Visitors, by=list(Country=pData$Country), FUN=sum)
    pGeo <- merge( geo, sumV, by='Country', all.geo = T, sort=F )
    colnames(pGeo)[4] <- "Totals"
    pGeo$Total <- pGeo$Total/(500*length(unique(data$Year)))
    ## Plot Map --
    map(database="world", regions=".", fill=TRUE, col="white", bg="lightblue", ylim=c(-60, 90), mar=c(0,0,0,0))
    points(pGeo$Lon,pGeo$Lat, col="green", pch=16, cex = pGeo$Total)
}
