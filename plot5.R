# Load data if necessary
if (!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Choose the mobile vehicle sources
SCC.mob <- unique(grep("mobile", SCC$EI.Sector, ignore.case=TRUE))
SCC.vehicle <- unique(grep("vehicle", SCC$EI.Sector, ignore.case=TRUE)) 
SCC.mob.vehicle <- intersect(SCC.mob,SCC.vehicle)
identical(SCC.vehicle,SCC.mob.vehicle)

# Subset of Baltimore's NEI data
if( exists("NEI") & !exists("NEI.mob.vehicle.Baltimore")){
  NEI.mob.vehicle.Baltimore <- NEI[NEI$fips=="24510" & NEI$SCC %in% SCC[SCC.mob.vehicle,]$SCC,]
}

png("plot5.png")

library(ggplot2)

#plot the annual emission from mobile vehicle in Baltimore
ggplot(NEI.mob.vehicle.Baltimore,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="blue",width=0.5)  + 
  labs(x="year", y=expression("PM"[2.5]*" Emission (tons) from Mobile Vehicles in Baltimore")) + 
  labs(title=expression("PM"[2.5]*" Emission from Mobile Vehicles in Baltimore (1999-2008)"))

dev.off()
