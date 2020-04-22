#Getting files
setwd("./expldataanalysisproject2")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "./airquality.zip")
unzip("./airquality.zip")
airquality <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

#Summarize data
vehiclecodes <- subset(codes, grepl("[Vv]ehicle", codes$SCC.Level.Two))
baltvehicledata <- subset(airquality, airquality$SCC %in% vehiclecodes$SCC & airquality$fips == "24510")
year <- c(1999, 2002, 2005,2008)
plot5input <- with(baltvehicledata, tapply(Emissions, year, sum, na.rm=TRUE, simplify=TRUE))
plot5input <- as.data.frame(cbind(year, plot5input))

#Plot data
library(ggplot2)
ggplot(plot5input, aes(x=year, y=plot5input))+
        geom_point() + geom_line()+
        ylim(c(0,max(plot5input[,2])))+
        xlab("Year") + ylab("Total Emissions (tons)")+ ggtitle("Baltimore City Vehicle Emissions, 1999-2008")

#Export to PNG
dev.copy(png, file="./plot5.png")
dev.off()
