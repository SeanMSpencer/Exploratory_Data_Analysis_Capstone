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

#filter by car and fips for Balt and LA

balt_car <- NEI[(NEI$fips == "24510") & (NEI$type == "ON-ROAD"), ]
balt_car$year <- as.factor(balt_car$year)

LA_car <- NEI[(NEI$fips == "06037") & (NEI$type == "ON-ROAD"), ]
LA_car$year <- as.factor(LA_car$year)

#group and summarize
balt_car_sum <- summarise(group_by(balt_car, year), Emissions = sum(Emissions))
LA_car_sum <- summarise(group_by(LA_car, year), Emissions = sum(Emissions))

balt_car_sum$location <- "Baltimore"
LA_car_sum$location <- "LA"

both <- rbind(balt_car_sum, LA_car_sum)

#plot

g <- ggplot(both, aes(x = year, y = Emissions, fill = location, label = round(Emissions, 2))) +
  geom_bar(stat = "identity") +
  facet_grid(location~., scales = "free") +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emissions in Tons")) + 
  ggtitle(expression("Total PM"[2.5]*" Emissions by Car in Baltimore and LA")) + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  geom_text(aes(label = round(Emissions, 2)), color = "black", size = 3, vjust = 1.5) 

ggsave("plot6.png", plot = g, width = 10, height = 8, units = "in")
