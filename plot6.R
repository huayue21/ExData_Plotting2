# Load data if necessary
if (!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Choose the mobile vehicle emission sources
SCC.mob <- unique(grep("mobile", SCC$EI.Sector, ignore.case=TRUE))
SCC.vehicle <- unique(grep("vehicle", SCC$EI.Sector, ignore.case=TRUE)) 
SCC.mobvehicle <- intersect(SCC.mob,SCC.vehicle)
identical(SCC.vehicle,SCC.mobvehicle)

# Extract Baltimore's and LA's mobile vehicle NEI data
NEI.mobvehicle.in <- 
  NEI[(NEI$fips=="24510" | NEI$fips=="06037")& NEI$SCC %in% SCC[SCC.mobvehicle,]$SCC,]

head(NEI.mobvehicle.in,2)
tail(NEI.mobvehicle.in,2)

NEI.mobvehicle.in <- 
  transform(NEI.mobvehicle.in,
            location = factor(fips, labels = c("Los Angeles County","Baltimore City")))

head(NEI.mobvehicle.in,2)
tail(NEI.mobvehicle.in,2)

# Sum of the mobile vehicle Emission w.r.t years and locations
annual.NEI.mobvehicle.in <- aggregate(Emissions ~ year + location, NEI.mobvehicle.in, sum)

png("plot6.png")

library(ggplot2)

#plot the trend graph
ggplot(data=annual.NEI.mobvehicle.in,aes(x=location, y=Emissions, fill =factor(year))) +
   geom_bar(stat="identity", position=position_dodge(),color = "black") + 
  labs(x="Location", y=expression("PM"[2.5]*" Emission (tons) from mobile vehicle")) + 
  labs(title=expression("PM"[2.5]*"Mobile Vehicle Emission Trends in LA and Baltimore"))+
  scale_fill_discrete(name="Year")

dev.off()