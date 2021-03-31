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

#get totals per year
total_emis <- summarise(group_by(NEI, year), Emissions = sum(Emissions))

#create plot
png("plot1.png")

plot <- barplot(total_emis$Emissions / 1000000, 
                names.arg = total_emis$year,
                ylim = c(0, 8),
                xlab = "Year",
                ylab = "PM2.5 Particulate Emissions (10^6 tons)",
                col = c("Red", "Orange", "Blue", "Green"),
                main = expression('Total PM'[2.5]*' Emissions per Year (10^6 tons)'))

text(x = plot, y = round(total_emis$Emissions / 1000000, 2), label = round(total_emis$Emissions / 1000000, 2), pos = 3, cex = 0.8, col = "black")

dev.off()
                
                

                