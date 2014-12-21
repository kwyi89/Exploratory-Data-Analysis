if (!require("Source_Classification_code.rds")) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileURL, "NEI_data.zip")
}

if (file.exists("NEI_data.zip")) {
  unzip("NEI_data.zip")
}

# Read both RDS files.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Take a look at the SCC data to see which are coal types
unique(SCC$EI.Sector)

# Subset data to include only coal-combustion
coal <- SCC[grepl("coal",SCC$Short.Name, ignore.case=T),]

# Merge coal subset and NEI data to find the amount of emission from coal combustion sources.
# And rename the columns.
m <- merge(NEI,coal,by="SCC")
ma <- aggregate(m[, "Emissions"], by=list(m$year), sum)
colnames(ma) <- c("Year","PM25_Emission")

# Create the plot.
png("plot4.png")
ggplot(ma,aes(x=Year,y=PM25_Emission)) + geom_line() + geom_point() + xlab("Year") + ylab("PM25 Emission in Tons") + ggtitle("Total Emissions of PM of coal combustion sources from 1999 - 2008") + theme(legend.position="none")
dev.off()
