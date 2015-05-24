# Load data if necessary
if (!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Get total emissions annually
if(exists("NEI") & !exists("annual.emission")){
  annual.emission <- aggregate(Emissions ~ year,data = NEI, FUN = sum)
}

png("plot1.png")

# Plot the graph
barplot(
  (annual.emission$Emissions)/10^6,
  names.arg=annual.emission$year,
  col  = "blue",
  space= 1.5,
  xlab = "Year",
  ylab = expression('Total PM'[2.5]*" Emissions(M tons)"),
  main = expression('Annual PM'[2.5]*" Emissions From All Sources in USA")
)
box()

dev.off()