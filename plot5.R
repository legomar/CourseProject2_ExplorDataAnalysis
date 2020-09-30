#Opening library required
library(dplyr)
library(ggplot2)
#download and read data
download_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(download_url, destfile = "data.zip")
unzip (zipfile = "data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Arranging variables 
scc_vehicles <- SCC[grep("[Vv]ehicle", SCC$EI.Sector), "SCC"]
vehicle_emissions <- NEI %>%   filter(SCC %in% scc_vehicles & fips == "24510") %>%  group_by(year) %>%  summarise(Emissions = sum(Emissions))
#Plotting and annotating graph, and providing png
dev.print(png, file = "plot5.png", width = 480, height = 480)
png(file="plot5.png", width=480, height=480, bg="transparent")
ggplot(coal_summary, aes(x=year, y=round(Emissions/1000,2), label=round(Emissions/1000,2), fill=year)) +
  geom_bar(stat="identity") + ylab(expression('PM'[2.5]*' Emissions in Kilotons')) + xlab("Year") +
  geom_label(aes(fill = year),colour = "white", fontface = "bold") +
  ggtitle("Baltimore Vehicle Emissions, 1999 to 2008.")