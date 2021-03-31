#By: Sean Spencer
#Exploratory Data Analysis Capstone Project
#Data: EPA PM2.5 Dataset 1995-2008


#Column summary: NEI
#fips: 5 digit number indicating US county
#SCC: name of the source indicated by a digit string (reference SCC table)
#Pollutant: string indicating pollutant
#Emissions: amount of pm2.5 emitted in tons
#type: the type of source (point, non-point, on-road, non-road)
#year: the year of emissions recorded.

library(dplyr)

#read in data

NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

balt <- summarise(group_by(filter(NEI, fips == "24510"), year), Emissions=sum(Emissions))

png("plot2.png")

plot <- barplot(balt$Emissions / 1000, 
                names.arg =  balt$year,
                ylim = c(0, 4),
                xlab = "Year",
                ylab = "PM2.5 Particulate Emissions (10^3 tons)",
                col = c("Red", "Orange", "Blue", "Green"),
                main = expression('Total PM'[2.5]*' Emissions per Year in Baltimore City (10^3 tons)'))

text(x = plot, y = round(balt$Emissions / 1000, 2), label = round(balt$Emissions / 1000, 2), pos = 3, cex = 0.8, col = "black")

dev.off()