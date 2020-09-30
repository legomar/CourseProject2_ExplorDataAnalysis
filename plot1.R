#download and read data
download_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(download_url, destfile = "data.zip")
unzip (zipfile = "data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Plotting and annotating graph, and providing png
dev.print(png, file = "plot1.png", width = 480, height = 480)
png(file="plot1.png", width=480, height=480, bg="transparent")
total_annual_emissions <- aggregate(Emissions ~ year, NEI, FUN = sum)
with(total_annual_emissions, 
     barplot(height=Emissions/1000, names.arg = year, col = total_annual_emissions$year, 
             xlab = "Year", ylab = expression('PM'[2.5]*' in Kilotons'),
             main = expression('Annual Emission PM'[2.5]*' from 1999 to 2008')))
dev.off()


