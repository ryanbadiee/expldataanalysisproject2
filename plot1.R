#Getting files
setwd("./expldataanalysisproject2")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "./airquality.zip")
unzip("./airquality.zip")
airquality <- readRDS("summarySCC_PM25.rds")

#Making matrix of total emission by year
embyyear<-with(airquality, tapply(Emissions, year, sum, na.rm=TRUE, simplify=TRUE))
plot1input <- cbind(c(1999, 2002, 2005, 2008), embyyear)

#Plotting data
plot(plot1input, 
     xlab = "Year",
     xaxt = "n",
     ylab = "Total PM25 Emissions (tons)",
     ylim = c(0, max(plot1input[,2])),
     main = "Total PM25 Emissions by Year",
     )
lines(plot1input[,1], plot1input[,2])
axis(1, at = c(1999, 2002, 2005,2008))

#Export to PNG
dev.copy(png, file="./plot1.png")
dev.off()
