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

# Aggregate using sum the Baltimore emissions data by year
annual.emission.Baltimore <- aggregate(Emissions ~ year, data = NEI.Baltimore, FUN = sum)

png("plot2.png")

barplot(
  (annual.emission.Baltimore$Emissions),
  names.arg=annual.emission.Baltimore$year,
  col  = "blue",space= 1.5,
  xlab = "Year",
  ylab = expression('Total PM'[2.5]*" Emissions (tons)"),
  main = expression('Annual PM'[2.5]*" Emissions of Baltimore City,MD")
)
box()

dev.off()