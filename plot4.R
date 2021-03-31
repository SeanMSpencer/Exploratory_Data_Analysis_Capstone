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


#filter by coal in SCC

coal_match <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
coal_emis <- SCC[coal_match, ]

#pull out emissions from NEI using SCC coal_emis.

coal_emis1 <- NEI[(NEI$SCC %in% coal_emis$SCC),]

#do sumamry similar to other

coal_emis_sum <- summarise(group_by(coal_emis1, year), Emissions = sum(Emissions))
coal_emis_sum$year <- as.factor(coal_emis_sum$year)

#plot

g <- ggplot(coal_emis_sum, aes(x = year, y = Emissions / 1000, fill = year, label = round(Emissions / 1000, 2)))+
  geom_bar(stat = "identity") +
  ylim(c(0, 650)) +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emissions in kilotons")) + 
  ggtitle(expression("Total PM"[2.5]*" Emissions by Coal Combustion")) + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  geom_text(aes(label = round(Emissions / 1000, 2)), color = "black", size = 5, vjust = -1) 

ggsave("plot4.png", plot = g, width = 10, height = 8, units = "in") 
  
  
