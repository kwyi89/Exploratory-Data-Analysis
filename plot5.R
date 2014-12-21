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

# Subset Baltimore City and motor vehicle data
balt <- subset(NEI, NEI$fips == 24510 & type == "ON-ROAD")

# create summary table
summary <- tapply(balt$Emissions,balt$year, FUN=sum)

# convert table to data frame
summary <- data.frame(summary)

# convert year column to numeric 
summary$year <- as.numeric(rownames(summary))

# name Emissions column
colnames(summary) <- c("Emissions","Year")

# create plot
png("plot5.png")
ggplot(summary) + geom_line(aes(x=Year, y=Emissions)) + ggtitle("Baltimore Emissions from Motor Vehicle Sources")
dev.off()