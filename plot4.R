#Getting files
setwd("./expldataanalysisproject2")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "./airquality.zip")
unzip("./airquality.zip")
airquality <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

#Summarize data
coalcodes <- subset(codes, grepl("[Cc]oal", codes$Short.Name))
coaldata <- subset(airquality, airquality$SCC %in% coalcodes$SCC)
year <- c(1999, 2002, 2005,2008)
plot4input <- with(coaldata, tapply(Emissions, year, sum, na.rm=TRUE, simplify=TRUE))
plot4input <- as.data.frame(cbind(year, plot4input))

#Plot data
library(ggplot2)
ggplot(plot4input, aes(x=year, y=plot4input))+
        geom_point() + geom_line()+
        ylim(c(0,max(plot4input[,2])))+
        xlab("Year") + ylab("Total Emissions (tons)")+ ggtitle("Total US Coal Emissions, 1999-2008")

#Export to PNG
dev.copy(png, file="./plot4.png")
dev.off()
