#Getting files
setwd("./expldataanalysisproject2")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "./airquality.zip")
unzip("./airquality.zip")
airquality <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

#Summarize data
library(reshape)
library(dplyr)
vehiclecodes <- subset(codes, grepl("[Vv]ehicle", codes$SCC.Level.Two))
baltvehicledata <- subset(airquality, airquality$SCC %in% vehiclecodes$SCC & airquality$fips == "24510")
lavehicledata <- subset(airquality, airquality$SCC %in% vehiclecodes$SCC & airquality$fips == "06037")
year <- c(1999, 2002, 2005,2008)
baltimore <- with(baltvehicledata, tapply(Emissions, year, sum, na.rm=TRUE, simplify=TRUE))
LA <- with(lavehicledata, tapply(Emissions, year, sum, na.rm=TRUE, simplify=TRUE))

#Reformat table for ggplot
plot6input <- as.data.frame(cbind(year, baltimore, LA))
plot6input <- melt.data.frame(plot6input, id.vars="year")
plot6input <- rename(plot6input, city = variable, emissions = value)

#Plot data
library(ggplot2)
ggplot(plot6input, aes(x=year, y=emissions, color=city, group=city))+
        geom_point() + geom_line()+
        xlab("Year") + ylab("Vehicle Emissions (tons)")+ ggtitle("Baltimore vs LA Vehicle Emissions, 1999-2008")

#Export to PNG
dev.copy(png, file="./plot6.png")
dev.off()
