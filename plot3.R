# Load data if necessary
if (!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Subset of Baltimore's NEI data
if( exists("NEI") & !exists("NEI.Baltimore")){
  NEI.Baltimore <- NEI[NEI$fips=="24510",]
}

# Sum of the Baltimore emissions data by year and type
annual.typed.emission.Baltimore <- aggregate(Emissions ~ year + type, data = NEI.Baltimore, FUN = sum)
annual.typed.emission.Baltimore$type.reorder <- 
  factor(annual.typed.emission.Baltimore$type, c("POINT", "NONPOINT", "ON-ROAD", "NON-ROAD"))

png("plot3.png")

#Plot The graph
library(ggplot2)
ggplot(data=annual.typed.emission.Baltimore, aes(x=type.reorder, y=Emissions, fill=factor(year))) +
  geom_bar(stat="identity", position=position_dodge(),color = "black") +
  labs(x="Emission source type", y=expression("PM"[2.5]*" Emission (tons) in Baltimore")) + 
  labs(title=expression("PM"[2.5]*" Emissions trends in Baltimore City,MD by source type"))+
  scale_fill_discrete(name="Year")

dev.off()