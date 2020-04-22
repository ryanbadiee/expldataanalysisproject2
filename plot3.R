#Getting files
setwd("./expldataanalysisproject2")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "./airquality.zip")
unzip("./airquality.zip")
airquality <- readRDS("summarySCC_PM25.rds")

#Summarize data
library(reshape)
library(dplyr)
baltdata <- subset(airquality, airquality$fips == "24510")
baltbyyeartype <- with(baltdata, tapply(Emissions, list(year, type), sum, na.rm=TRUE, simplify=TRUE))
plot3input <- melt(baltbyyeartype)
plot3input <- rename(plot3input, year = X1, type = X2, emissions = value)

#Plot data
library(ggplot2)
ggplot(plot3input, aes(x=year, y=emissions, color=type, group=type))+
        geom_point() + geom_line()+
        xlab("Year") + ylab("Total Emissions (tons)")+ ggtitle("Baltimore Emissions by Source, 1999-2008")

#Export to PNG
dev.copy(png, file="./plot3.png")
dev.off()
