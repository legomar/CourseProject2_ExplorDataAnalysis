#Opening library required
library(dplyr)
library(ggplot2)
#download and read data
download_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(download_url, destfile = "data.zip")
unzip (zipfile = "data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Plotting and annotating graph, and providing png
dev.print(png, file = "plot3.png", width = 480, height = 480)
png(file="plot3.png", width=480, height=480, bg="transparent")
b_emissions <- NEI %>%   filter(fips == "24510") %>%   group_by(year, type) %>%   summarise(Emissions=sum(Emissions))
ggplot(data = b_emissions, aes(x = factor(year), y = Emissions, fill = type, colore = "black")) +
  geom_bar(stat = "identity") + facet_grid(. ~ type) + 
  xlab("Year") + ylab(expression('PM'[2.5]*' Emission')) +
  ggtitle("Baltimore Emissions by Source Type") 
dev.off()
