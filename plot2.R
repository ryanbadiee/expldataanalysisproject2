#Getting files
setwd("./expldataanalysisproject2")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "./airquality.zip")
unzip("./airquality.zip")
airquality <- readRDS("summarySCC_PM25.rds")

#Subset data
baltdata <- subset(airquality, airquality$fips == "24510")
baltbyyear <- with(baltdata, tapply(Emissions, year, sum, na.rm=TRUE, simplify=TRUE))
plot2input <- cbind(c(1999, 2002, 2005, 2008), baltbyyear)

#Plot data
plot(plot2input, 
     xlab = "Year",
     xaxt = "n",
     ylab = "PM25 Emissions (tons)",
     ylim = c(0, max(plot2input[,2])),
     main = "Baltimore City PM25 Emissions by Year",
)
lines(plot2input[,1], plot2input[,2])
axis(1, at = c(1999, 2002, 2005,2008))

#Export to PNG
dev.copy(png, file="./plot2.png")
dev.off()
