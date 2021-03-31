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
library(ggplot2)

#read in data

NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

#filter on Baltimore
balt1 <- filter(NEI, fips == "24510")

#group by type and year and get the sum of emisisons per year. Making year a factor to make plotting easier.
type <- summarise(group_by(balt1, type, year), Emissions = sum(Emissions))
type$year <- as.factor(type$year)

#plot

g <- ggplot(type, aes(year, Emissions, fill = type))

g <- g + 
  geom_bar(stat = "identity", position = 'dodge') +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emissions in Tons")) +
  ggtitle(expression("PM"[2.5]*" Emissions (in tons) per Year in Baltimore City per Source")) +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_text(aes(label = round(Emissions, 2)), color = "black", size = 3, vjust = -1, position = position_dodge(.9)) 
    
ggsave("plot3.png", plot = g, width = 10, height = 8, units = "in") 
  
