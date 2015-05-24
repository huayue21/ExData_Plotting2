# Load data if necessary
if (!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Choose coal combustion-related sources
SCC.comb <- unique(grep("comb", SCC$EI.Sector, ignore.case=TRUE))
SCC.coal <- unique(grep("coal", SCC$EI.Sector, ignore.case=TRUE)) 
SCC.coalcomb <- intersect(SCC.comb,SCC.coal)

# Extract the data of interest
NEI.coalcomb <- NEI[NEI$SCC %in% SCC[SCC.coalcomb,"SCC"],]

png("plot4.png")

library(ggplot2)

# plot the emissions from coal combustion-related sources by years
ggplot(NEI.coalcomb,aes(factor(year),Emissions/10^3)) +
  geom_bar(stat="identity",fill="blue",width=0.5)  + 
  labs(x="year", y=expression("PM"[2.5]*" Emission (kilotons) from Coal Combustion in USA")) + 
  labs(title=expression("PM"[2.5]*" Emission from Coal Combustion in USA(1999-2008)"))

dev.off()