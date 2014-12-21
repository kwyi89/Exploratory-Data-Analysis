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

# Subset the data into only "On-ROAD" and two counties (fips = "24510',"06037")
NEI_sub <- subset(NEI, type=="ON-ROAD" & fips %in% c("24510","06037"))

# Aggregate the data into a long form to use ggplot later
tot <- aggregate(Emissions ~ fips + year, NEI_sub, sum)

# create plot
png("plot6.png")
ggplot(tot, aes(x=year, y=Emissions, color=fips)) + geom_line() + ggtitle("Emissions in Baltimore vs. LA from Motor Vehicle")
dev.off()